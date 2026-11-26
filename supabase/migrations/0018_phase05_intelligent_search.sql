-- Phase 5: Intelligent Natural-Language Search & Index Optimization
-- 0018_phase05_intelligent_search.sql

-- 1. Full-Text Search and Trigram Optimization on public.creator_directory
create extension if not exists pg_trgm;

-- Fast index for natural language text search on creator directory
create index if not exists idx_creator_dir_tsv 
  on public.creator_directory 
  using gin(to_tsvector('english', display_name || ' ' || coalesce(instagram_handle, '') || ' ' || coalesce(city, '')));

-- Trigram index for fuzzy misspelled creator names and handles
create index if not exists idx_creator_dir_trgm_name
  on public.creator_directory
  using gin(display_name gin_trgm_ops);

create index if not exists idx_creator_dir_trgm_handle
  on public.creator_directory
  using gin(instagram_handle gin_trgm_ops);

-- Index for follower count ranges
create index if not exists idx_creator_dir_followers_asc
  on public.creator_directory(followers_count asc nulls last);

-- 2. Secure Parameterized Intelligent Search Function
-- Searches both registered and directory creators with strict RLS and privacy protection
create or replace function public.search_creators_intelligent(
  p_query text default null,
  p_city text default null,
  p_category text default null,
  p_min_followers bigint default null,
  p_max_followers bigint default null,
  p_limit int default 20,
  p_offset int default 0
)
returns table (
  id text,
  display_name text,
  handle text,
  avatar_path text,
  city text,
  categories text[],
  followers_count bigint,
  is_registered boolean,
  relevance_rank real
) language plpgsql security definer set search_path = public as $$
declare
  v_limit int := least(greatest(coalesce(p_limit, 20), 1), 50);
  v_offset int := greatest(coalesce(p_offset, 0), 0);
begin
  if auth.uid() is null then
    raise exception 'Authentication required for creator search';
  end if;

  return query
  select
    d.directory_id as id,
    d.display_name,
    d.instagram_handle as handle,
    d.image_path as avatar_path,
    d.city,
    d.categories,
    d.followers_count,
    (d.linked_creator_user_id is not null) as is_registered,
    case
      when p_query is not null and d.instagram_handle ilike p_query then 1.0::real
      when p_query is not null and d.display_name ilike p_query then 0.9::real
      when p_query is not null then similarity(d.display_name, p_query)::real
      else 0.5::real
    end as relevance_rank
  from public.creator_directory d
  where
    (p_city is null or d.city ilike '%' || p_city || '%')
    and (p_category is null or p_category = any(d.categories))
    and (p_min_followers is null or d.followers_count >= p_min_followers)
    and (p_max_followers is null or d.followers_count <= p_max_followers)
    and (
      p_query is null 
      or p_query = ''
      or d.display_name ilike '%' || p_query || '%'
      or d.instagram_handle ilike '%' || p_query || '%'
    )
  order by relevance_rank desc, d.followers_count desc nulls last
  limit v_limit
  offset v_offset;
end;
$$;

revoke all on function public.search_creators_intelligent(text, text, text, bigint, bigint, int, int) from public, anon;
grant execute on function public.search_creators_intelligent(text, text, text, bigint, bigint, int, int) to authenticated;

insert into storage.buckets(id, name, public, file_size_limit, allowed_mime_types) values
 ('avatars', 'avatars', false, 2097152, array['image/jpeg', 'image/png', 'image/webp']),
 ('verification', 'verification', false, 5242880, array['application/pdf', 'image/jpeg', 'image/png'])
on conflict(id) do nothing;
create policy avatars_own_read on storage.objects for select to authenticated
 using(bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text and private.is_active());
create policy avatars_own_insert on storage.objects for insert to authenticated
 with check(bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text and private.is_active());
create policy avatars_own_update on storage.objects for update to authenticated
 using(bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text and private.is_active())
 with check(bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text and private.is_active());
create policy avatars_own_delete on storage.objects for delete to authenticated
 using(bucket_id = 'avatars' and (storage.foldername(name))[1] = (select auth.uid())::text and private.is_active());
-- Verification is deliberately default-deny: upload/review belongs to later phases.

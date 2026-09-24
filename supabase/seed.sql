-- Synthetic local fixtures; no passwords, tokens or deliverable mailboxes.
insert into auth.users(id, aud, role, email, email_confirmed_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at)
values
 ('11111111-1111-4111-8111-111111111111','authenticated','authenticated','creator-a@example.invalid',now(),'{"provider":"email","providers":["email"]}','{}',now(),now()),
 ('22222222-2222-4222-8222-222222222222','authenticated','authenticated','creator-b@example.invalid',now(),'{"provider":"email","providers":["email"]}','{}',now(),now()),
 ('33333333-3333-4333-8333-333333333333','authenticated','authenticated','operator@example.invalid',now(),'{"provider":"email","providers":["email"]}','{}',now(),now())
on conflict(id) do nothing;
update public.profiles set display_name = case id when '11111111-1111-4111-8111-111111111111' then 'Creator A' when '22222222-2222-4222-8222-222222222222' then 'Creator B' else 'Local Operator' end,
 account_state = 'active', primary_role_label = case when id = '33333333-3333-4333-8333-333333333333' then 'admin'::public.professional_role else 'creator'::public.professional_role end
where id in ('11111111-1111-4111-8111-111111111111','22222222-2222-4222-8222-222222222222','33333333-3333-4333-8333-333333333333');
insert into public.professional_roles(user_id, role_type, is_primary)
select id, primary_role_label, true from public.profiles where id in ('11111111-1111-4111-8111-111111111111','22222222-2222-4222-8222-222222222222','33333333-3333-4333-8333-333333333333') on conflict do nothing;

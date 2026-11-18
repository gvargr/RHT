-- Run in Supabase: SQL Editor > New query > paste > Run.
-- Safe to run more than once, and safe to run over the older redheads-only table.

create table if not exists public.votes (
  voter_id   uuid not null,
  category   text not null default 'redheads',
  points     jsonb not null check (jsonb_typeof(points) = 'object'),
  updated_at timestamptz not null default now()
);

-- Upgrade path for the original single-category table
alter table public.votes add column if not exists category text not null default 'redheads';
alter table public.votes drop constraint if exists votes_pkey;
alter table public.votes add primary key (voter_id, category);

alter table public.votes drop constraint if exists votes_category_check;
alter table public.votes add constraint votes_category_check
  check (category in ('redheads','blondes','brunettes','black','white','colourful'));

alter table public.votes enable row level security;

drop policy if exists "anyone can read votes"      on public.votes;
drop policy if exists "anyone can add a ballot"    on public.votes;
drop policy if exists "anyone can update a ballot" on public.votes;
create policy "anyone can read votes"      on public.votes for select to anon using (true);
create policy "anyone can add a ballot"    on public.votes for insert to anon with check (true);
create policy "anyone can update a ballot" on public.votes for update to anon using (true) with check (true);

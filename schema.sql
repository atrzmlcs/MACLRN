-- Supabase Storage Configuration:
-- Create a public storage bucket named "models" to host spam_model.onnx and vocab.json

create table flagged_spam (
  id bigint generated always as identity primary key,
  created_at timestamptz default now(),
  sparse_tfidf jsonb not null,
  processed boolean default false
);

alter table flagged_spam enable row level security;

create policy "Allow anonymous inserts"
on flagged_spam for insert
to anon
with check (true);

grant all on table public.flagged_spam to service_role;
grant insert on table public.flagged_spam to anon;
grant usage, select on all sequences in schema public to anon, service_role;

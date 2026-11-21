-- GTM Automation OS V1 schema for Supabase PostgreSQL
create extension if not exists pgcrypto;

create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  first_name text,
  last_name text,
  company_name text,
  website text,
  industry text,
  employees integer,
  country text,
  job_title text,
  business_need text,
  source text default 'website',
  enrichment_status text default 'pending',
  enrichment_source text,
  signals jsonb not null default '[]'::jsonb,
  score integer not null default 0 check (score between 0 and 100),
  score_band text not null default 'COLD' check (score_band in ('HOT','WARM','COLD')),
  score_reasons jsonb not null default '[]'::jsonb,
  owner text,
  status text not null default 'new',
  ai_mode text default 'rules_only',
  ai_qualification jsonb not null default '{}'::jsonb,
  human_approval_required boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists leads_score_band_idx on public.leads(score_band);
create index if not exists leads_created_at_idx on public.leads(created_at desc);
create index if not exists leads_owner_idx on public.leads(owner);

create table if not exists public.events (
  id bigint generated always as identity primary key,
  lead_email text,
  event_type text not null,
  detail text,
  created_at timestamptz not null default now()
);
create index if not exists events_created_at_idx on public.events(created_at desc);

-- V1 security baseline:
-- Keep RLS enabled. n8n uses a Supabase Secret API key server-side.
-- Dashboard data is served through a local n8n webhook in this demo.
alter table public.leads enable row level security;
alter table public.events enable row level security;

-- Do NOT add public SELECT/INSERT policies for the server-side workflow.
-- The service-role key bypasses RLS. Never put it in dashboard/browser code.

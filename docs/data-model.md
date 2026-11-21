# Data model

The canonical schema reference is `supabase/schema.sql`. It creates two public tables and enables row-level security on both.

## `public.leads`

| Field group | Representative columns | Purpose |
|---|---|---|
| Identity | `id`, `email` | UUID primary key and unique lead email. |
| Contact/company | `first_name`, `last_name`, `company_name`, `website`, `industry`, `employees`, `country`, `job_title`, `business_need`, `source` | Normalized submitted or fixture data. |
| Enrichment | `enrichment_status`, `enrichment_source`, `signals` | Indicates whether local mock enrichment supplied data. |
| Qualification | `score`, `score_band`, `score_reasons`, `owner`, `status` | Rule-based score, band, rationale, and route. Score is constrained to 0–100 and bands to HOT/WARM/COLD. |
| AI/human-review placeholders | `ai_mode`, `ai_qualification`, `human_approval_required` | V1 records rules-only mode and a human review flag; no AI provider is called. |
| Timestamps | `created_at`, `updated_at` | Row creation and update times. |

Indexes support score-band, owner, and created-time lookups. `email` is unique and is used for the WF01 upsert conflict target.

## `public.events`

| Column | Purpose |
|---|---|
| `id` | Identity primary key. |
| `lead_email` | Related lead email where supplied. |
| `event_type` | Required event category; WF01 writes `lead_processed`. |
| `detail` | Processing summary. |
| `created_at` | Event timestamp. |

An index supports descending time-oriented event queries. V1 does not define a foreign key from event email to the lead table.

## Access model

RLS is enabled. The n8n server uses a Supabase Secret API key for REST requests; the dashboard does not connect directly to Supabase. The key bypasses RLS and must remain private. Do not create public policies for this server-side workflow without a deliberate security review.

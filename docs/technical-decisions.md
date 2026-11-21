# Technical decisions

## n8n-first orchestration

V1 uses n8n webhooks and workflow nodes as the orchestration layer. It avoids introducing another application backend and keeps intake, processing, persistence, and dashboard data retrieval visible as workflow steps.

## Mock enrichment and deterministic scoring

Enrichment fixtures and explicit scoring rules keep the demo reproducible without paid services or external provider calls. The score is inspectable and explainable, but is not represented as a validated predictive model.

## Supabase persistence

Supabase Postgres and its REST API provide durable lead and event storage. The project schema enables RLS; n8n uses a server-side Secret API key, while the browser only calls local n8n webhooks.

## Static dashboard

A static HTML/CSS/JavaScript dashboard served by Nginx avoids a second application backend. Its API dependency is the WF02 webhook. Authentication and production authorization are deliberately identified as gaps rather than assumed capabilities.

## Local Docker Compose

Compose runs n8n and Nginx and persists n8n state in a named volume. Host bindings are loopback-only; n8n is available at port 5679 and the dashboard at 8080. Supabase remains externally managed.

## Human review and outbound boundary

Scoring can assign an owner and mark review requirements, but V1 does not send email, messaging, CRM writes, or other outbound communication. Future integrations must add explicit consent/suppression checks and human approval.

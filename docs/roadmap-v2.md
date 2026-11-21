# V2 roadmap (planned)

Nothing in this roadmap is implemented by the V1 workflow exports. The listed work requires separate design, credentials, testing, and security review.

1. **Real multi-source ingestion:** Add explicitly supported lead-source connectors, validation, provenance, deduplication, and consent checks.
2. **Apollo integration:** Add an approved API integration for prospect data, respecting provider terms, rate limits, and data retention rules.
3. **Clay enrichment:** Replace or extend the fixture branch with an approved Clay integration and documented failure behavior.
4. **Company intent signals:** Define allowed signal sources, freshness, confidence, and transparent storage before consuming intent data.
5. **CRM synchronization:** Add HubSpot and/or Salesforce create/update flows with idempotency and conflict handling.
6. **AI lead qualification:** Evaluate constrained structured outputs, privacy controls, explainability, cost controls, and mandatory human review. No AI API is called in V1.
7. **Production operations:** Add authentication, webhook signature verification, retries, dead-letter handling, monitoring, alerting, backups, and retention/deletion controls.

Prioritize data protection, human approval, and observable failure recovery before any outbound action or public deployment.

# Testing results

## Static checks recorded during repository preparation

- `docker compose config --quiet` passed after the local Compose configuration was prepared.
- All three workflow exports parsed as JSON, and node connection references resolved.
- JavaScript syntax in workflow Code nodes was checked during project repair; the WF01 email/domain regex escaping was corrected.
- Dashboard JavaScript syntax was checked during project repair.
- Supabase read-only GET requests for `leads` and `events` returned HTTP 200 during a connectivity diagnostic. No response data or credentials are recorded here.
- Local n8n health and dashboard HTTP availability were verified during deployment checks.

These are observations from local checks, not a CI pipeline or a guarantee for a fresh clone. Container state, credentials, and external Supabase configuration may have changed since checks ran.

## Not tested as part of this package audit

- No fresh end-to-end synthetic lead was written to Supabase during this packaging pass.
- Workflow import/activation compatibility was not re-tested against a clean n8n instance.
- Authentication, webhook signing, rate limits, retry/dead-letter behavior, and public deployment are not implemented or tested.
- No performance, conversion, or business outcome metrics are claimed.

## Re-run locally

```bash
docker compose config --quiet
# After reviewing .env and approving local deployment:
docker compose pull
docker compose up -d --pull always
docker compose ps
```

Test workflow behavior only with a disposable Supabase project and synthetic records. The seeder writes demo records when activated and invoked.

# Deployment Notes (Coolify-ready)

This project is designed to be deployable using Coolify or similar platforms.

## Architecture Overview
Supabase: Database for transcript runs and detected anomalies
n8n: Workflow orchestration and quality checks
UI: Minimal static HTML page for surfacing anomalies

## Services
Supabase (managed, external)
n8n (Docker container)
Static UI (HTML)

## Environment Variables
SUPABASE_URL
SUPABASE_ANON_KEY
N8N_HOST
N8N_PORT

## Ports
n8n: 5678
UI (static): 3000 (if served)

## Notes
n8n workflow export is included in the repository
Supabase schema and seed data are provided under /supabase/schema.sql
n8n Cloud was used during development; workflow is portable to self-hosted n8n

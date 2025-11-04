# Backend - Database Assets

This folder contains database SQL for PostgreSQL and docker-compose to run a local DB.

Structure:
- database/
  - migrations/001_init.sql (initial tables, indexes)
  - seed/seed.sql (demo data)
  - schema.sql (aggregates migrations for convenience)
- .env.example (copy to .env)
- docker-compose.yml (starts postgres)
- node-api/ (Node.js + Express + TypeScript backend API)

Usage:
1) cd backend && cp .env.example .env
# Ensure the Node API also has environment configured
cd node-api && cp .env.example .env && cd ..
2) docker compose up -d
3) Wait for Postgres healthcheck to pass (pg_isready)
4) Apply migrations:
   docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/migrations/001_init.sql"
5) Seed (optional):
   docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/seed/seed.sql"

API + DB stack:
- cd backend && docker compose -f docker-compose.api.yml up -d --build
- Wait for both healthchecks:
  - Postgres via pg_isready
  - API via GET /
- API endpoints:
  - POST /api/auth/login
  - POST /api/attendance/mark
  - GET /api/attendance/daily?date=YYYY-MM-DD
  - GET /api/attendance/weekly?weekStart=YYYY-MM-DD
  - GET /api/sse/attendance (SSE)
- Docs helper: GET /api/docs

API service:
- See node-api/ for the TypeScript API.
- Configure node-api/.env to point to this Postgres (use DATABASE_URL or DB_*).
- Start in dev: cd node-api && npm ci && npm run dev
- Docker: build and run Dockerfile in node-api/

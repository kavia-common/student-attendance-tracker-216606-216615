# Backend - Database Assets

This folder contains database SQL for PostgreSQL and docker-compose to run a local DB.

Structure:
- database/
  - migrations/001_init.sql (initial tables, indexes)
  - seed/seed.sql (demo data)
  - schema.sql (aggregates migrations for convenience)
- .env.example (copy to .env)
- docker-compose.yml (starts postgres)

Usage:
1) cd backend && cp .env.example .env
2) docker compose up -d
3) Apply migrations:
   docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/migrations/001_init.sql"
4) Seed (optional):
   docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/seed/seed.sql"

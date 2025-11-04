# student-attendance-tracker-216606-216615

CI note:
- If CI reports "Could not determine project root directory for Flutter project",
  ensure the working directory is set to:
  student-attendance-tracker-216606-216615/attendance_tracker_frontend
- Or use helper to print the correct path:
  bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh
- See also: student-attendance-tracker-216606-216615/CI_USAGE.md

This workspace contains:
- Flutter mobile app at: student-attendance-tracker-216606-216615/attendance_tracker_frontend
- Backend:
  - Database assets at: student-attendance-tracker-216606-216615/backend
  - Node API at: student-attendance-tracker-216606-216615/backend/node-api

## Backend Database (PostgreSQL)

We provide a dockerized PostgreSQL setup, SQL migrations, and seed data to bootstrap the environment.

### 1) Configure environment
Create a .env file in backend/ based on .env.example:

```
cd student-attendance-tracker-216606-216615/backend
cp .env.example .env
# Optionally edit DB_* values; defaults are fine for local dev
```

The following environment variables are used:
- DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD
- DATABASE_URL (postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME})

### 2) Start Postgres
```
docker compose up -d
# Wait for healthcheck to pass
docker compose ps
```

### 3) Apply migrations
From inside the backend directory, exec into the Postgres container and run the initial migration:

```
# Open a shell in the container
docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/migrations/001_init.sql"
```

Alternatively, to apply the aggregated schema file (includes 001_init.sql):
```
docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/schema.sql"
```

### 4) Seed demo data (optional)
```
docker compose exec -u postgres postgres bash -lc "psql -d $DB_NAME -f /docker-entrypoint-initdb.d/seed/seed.sql"
```

After seeding, the database will contain:
- Demo students (Alice, Bob, Charlie)
- Attendance for today across two periods with present/absent samples

### 5) Connecting from backend code
Use DATABASE_URL or the discrete DB_* variables from .env. Do not hardcode credentials; load from environment.

Example URL:
```
postgresql://attendance_user:attendance_pass@localhost:5432/attendance_db
```

### 6) Table overview
- students(id UUID PK, name, email UNIQUE, created_at)
- attendance_records(id UUID PK, student_id FK->students, date, period, status CHECK in ('present','absent'), created_at)
- sessions(id UUID PK, student_id FK->students, token UNIQUE, expires_at)
- Indexes: attendance_records(student_id, date), attendance_records(date)

## Frontend (Flutter)
See app-specific README:
student-attendance-tracker-216606-216615/attendance_tracker_frontend/README.md

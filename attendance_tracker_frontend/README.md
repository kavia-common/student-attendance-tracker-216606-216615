# Student Attendance Tracker Monorepo

This repository contains:
- Flutter mobile app (project root):
  student-attendance-tracker-216606-216615/attendance_tracker_frontend
- Backend database assets (PostgreSQL) and Node API:
  student-attendance-tracker-216606-216615/backend
  ├─ database/ (migrations, seed, schema)
  ├─ docker-compose.yml (DB only)
  ├─ docker-compose.api.yml (API + DB stack)
  └─ node-api/ (Express + TypeScript API)

Important:
Some CI systems fail to detect the Flutter project root automatically.

Flutter project root path (absolute or relative from repo root):
student-attendance-tracker-216606-216615/attendance_tracker_frontend

Use the helpers to ensure correct working directory:

- Make:
  - make flutter-root
  - make flutter-get
  - make flutter-analyze
  - make flutter-test

- Shell helper:
  bash student-attendance-tracker-216606-216615/ci_run_flutter.sh get
  bash student-attendance-tracker-216606-216615/ci_run_flutter.sh analyze
  bash student-attendance-tracker-216606-216615/ci_run_flutter.sh test

Backend quickstart:
- DB only:
  cd student-attendance-tracker-216606-216615/backend
  cp .env.example .env
  docker compose up -d
  # apply migrations/seed per backend README

- API + DB:
  cd student-attendance-tracker-216606-216615/backend
  cp .env.example .env
  docker compose -f docker-compose.api.yml up -d --build

Frontend ↔ Backend:
- API_BASE_URL (.env in Flutter) should point to the Node API (default http://localhost:8080).
- See attendance_tracker_frontend/INTEGRATION_BACKEND.md for details.

Troubleshooting Flutter root detection:
- Ensure you are running commands from:
  student-attendance-tracker-216606-216615/attendance_tracker_frontend
- Or use the helpers above.
- The Flutter root contains:
  pubspec.yaml, lib/main.dart, analysis_options.yaml, android/

Repository health endpoints:
- Node API: GET http://localhost:8080/
- Postgres: via docker healthcheck (pg_isready)

License: MIT

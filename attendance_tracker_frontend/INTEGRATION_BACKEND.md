# Frontend ↔ Backend Integration

This Flutter app can operate in two modes:
- Local/offline (USE_REMOTE=false): uses SQLite only. This is the default in tests.
- Remote integrated (USE_REMOTE=true): uses the Node API for Auth and Attendance.

Environment variables (attendance_tracker_frontend/.env):
```
API_BASE_URL=http://localhost:8080
USE_REMOTE=true
FEATURE_FLAG_REALTIME=false
```

Notes:
- Env.apiBaseUrl defaults to http://localhost:8080 if .env missing.
- Env.useRemote defaults to true for integrated runs.
- Env.featureRealtime controls an optional SSE subscription to /api/sse/attendance.

Backend stack:
- See backend/node-api for API and backend/database for Postgres.
- Quick start:
  - cd student-attendance-tracker-216606-216615/backend
  - cp .env.example .env
  - docker compose -f docker-compose.api.yml up -d --build
  - Health: GET http://localhost:8080/

API endpoints used by app:
- POST /api/auth/login
- POST /api/attendance/mark
- GET /api/attendance/daily?date=YYYY-MM-DD
- GET /api/attendance/weekly?weekStart=YYYY-MM-DD
- GET /api/sse/attendance (optional, when FEATURE_FLAG_REALTIME=true)

Client behavior:
- LoginScreen:
  - When USE_REMOTE=true: performs real login with email/password and stores JWT in SharedPreferences.
  - When USE_REMOTE=false: "Proceed to Dashboard" sets local logged-in state for demo/tests.
- Attendance actions:
  - Mark: If remote and logged in, POST /api/attendance/mark with Bearer token.
  - Daily/Weekly: If remote, fetch lists via GET endpoints; else reads from local DB.
- SSE: If FEATURE_FLAG_REALTIME=true, Daily report subscribes to /api/sse/attendance and refreshes on events.

Runbook:
1) Start backend (see above).
2) Configure Flutter .env:
   ```
   API_BASE_URL=http://localhost:8080
   USE_REMOTE=true
   FEATURE_FLAG_REALTIME=false
   ```
3) flutter pub get && flutter run
4) Login with seeded credentials, e.g. alice@example.com / password.
5) Mark attendance; open Daily Report to see updates. Turn on FEATURE_FLAG_REALTIME to auto-refresh.

Troubleshooting:
- 401 Unauthorized: ensure login succeeded and token stored.
- CORS: backend allows '*' or provided origins; set CORS_ORIGIN in backend .env if needed.
- Tests failing: set USE_REMOTE=false in .env during CI/local tests to use SQLite.


# Attendance Backend API (Node.js + Express + TypeScript)

This service provides authentication (demo) and attendance endpoints backed by PostgreSQL.

## Features
- Express + TypeScript
- Postgres connection with pg Pool (DATABASE_URL or discrete DB_* envs)
- Token-based auth (JWT)
- CORS, Helmet, rate limiting
- Request validation via Joi
- Attendance endpoints (mark, daily, weekly)
- Optional realtime via Server-Sent Events (SSE) at `/api/sse/attendance`
- Dockerfile for deployment

## Environment

Copy .env.example to .env and adjust as needed:

```
cp .env.example .env
```

Variables:
- PORT: default 8080
- CORS_ORIGIN: comma separated origins
- JWT_SECRET, JWT_EXPIRES_IN
- DATABASE_URL or DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASSWORD

For local DB, see workspace backend database setup at:
student-attendance-tracker-216606-216615/attendance_tracker_frontend/student-attendance-tracker-216606-216615/backend/

## Development

```
npm ci
npm run dev
```

Build + run:

```
npm run build
npm start
```

Docker:

```
docker build -t attendance-api .
docker run --rm -p 8080:8080 --env-file .env attendance-api
```

## API
- OpenAPI spec: openapi.yaml
  - Make sure your environment variables (.env) are set so the app starts and the OpenAPI describes the current routes.
  - Implemented endpoints reflected in the spec:
    - POST /api/auth/login
    - POST /api/attendance/mark
    - GET /api/attendance/daily
    - GET /api/attendance/weekly
    - GET /api/sse/attendance

- GET `/` -> health
- POST `/api/auth/login` -> { email, password } => { token, user }
  - Demo rule: password must be `password`
- POST `/api/attendance/mark` (Bearer) -> create record
  - body: { studentId(UUID), date(YYYY-MM-DD), period, status: present|absent }
- GET `/api/attendance/daily?date=YYYY-MM-DD` (Bearer)
- GET `/api/attendance/weekly?weekStart=YYYY-MM-DD` (Bearer)
- GET `/api/sse/attendance` (Bearer) -> text/event-stream

## Smoke test (assuming DB seeded as per SQL assets)

1) Login as seeded student:
```
curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"alice@example.com","password":"password"}'
```

2) Use token:
```
TOKEN="..."; DATE=$(date +%F)
curl -s -X POST http://localhost:8080/api/attendance/mark \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"studentId\":\"00000000-0000-0000-0000-000000000001\",\"date\":\"$DATE\",\"period\":\"Period 1\",\"status\":\"present\"}"
```

3) Fetch daily:
```
curl -s -H "Authorization: Bearer $TOKEN" "http://localhost:8080/api/attendance/daily?date=$DATE"
```

4) Weekly:
```
WEEK_START="$DATE"
curl -s -H "Authorization: Bearer $TOKEN" "http://localhost:8080/api/attendance/weekly?weekStart=$WEEK_START"
```

5) SSE:
```
curl -N -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/sse/attendance
```

## Notes
- This demo uses a simplified auth flow; for production store password hashes and implement proper signup flows.
- Ensure database migrations from the SQL assets are applied before running the API.

Health:
- GET http://localhost:8080/ -> returns basic API metadata and uptime.
- GET http://localhost:8080/api/docs -> returns a small JSON with OpenAPI info and SSE usage.

SSE Example (Browser):
```js
const token = '...'; // from login
const es = new EventSource('/api/sse/attendance', { withCredentials: false });
es.addEventListener('attendance.marked', (e) => console.log('Event:', e.data));
```

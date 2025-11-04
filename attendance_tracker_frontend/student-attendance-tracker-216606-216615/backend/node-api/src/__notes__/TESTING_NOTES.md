Minimal testing

- Automated unit tests are not included. Use these quick smoke checks:
  1) Start Postgres via docker-compose from the database assets and apply migrations/seed.
  2) Run the API (npm run dev).
  3) Follow README curl examples to verify login, mark, daily, weekly, and SSE.

Future:
- Add supertest + jest for route-level tests.

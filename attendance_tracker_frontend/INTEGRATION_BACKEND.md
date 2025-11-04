# Frontend ↔ Backend Integration

- Flutter app reads API base URL from .env via Env.apiBaseUrl (default http://localhost:8080).
- To use the new Node API:
  1) Run the API service (see backend/node-api/README.md).
  2) Ensure the Flutter .env contains:
     ```
     API_BASE_URL=http://localhost:8080
     ```
  3) Update repositories to call real endpoints when switching from local SQLite to remote API (future task).

Authentication:
- Obtain token via POST /api/auth/login (email: alice@example.com, password: password after seeding).
- Include header: Authorization: Bearer <token> for protected routes.

Realtime:
- Subscribe to GET /api/sse/attendance for server-sent events if needed on dashboard.

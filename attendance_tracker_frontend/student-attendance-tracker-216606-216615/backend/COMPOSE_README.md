# Backend Compose Stacks

Options:

1) Database only (provided already):
   - docker-compose.yml -> starts PostgreSQL
   - Apply migrations/seed from `database/` via psql commands shown in README.md

2) API + Database (new):
   - docker-compose.api.yml -> builds and runs Node API and Postgres together
   - Steps:
     ```
     cd student-attendance-tracker-216606-216615/backend
     cp .env.example .env      # if not already present
     docker compose -f docker-compose.api.yml up -d --build
     ```
   - After healthy:
     - API: http://localhost:8080
     - Use curl smoke tests in node-api/README.md

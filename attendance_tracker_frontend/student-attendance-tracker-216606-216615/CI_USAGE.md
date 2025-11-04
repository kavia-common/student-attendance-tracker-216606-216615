# CI Usage

To avoid "Could not determine project root directory for Flutter project", run Flutter tasks via the helpers that set the working directory correctly.

From repository root:

- Print Flutter root:
  ```
  make flutter-root
  ```
- Install deps:
  ```
  make flutter-get
  ```
- Analyze:
  ```
  make flutter-analyze
  ```
- Test:
  ```
  make flutter-test
  ```

Alternatively, using the shell helper:
```
bash student-attendance-tracker-216606-216615/ci_run_flutter.sh get
bash student-attendance-tracker-216606-216615/ci_run_flutter.sh analyze
bash student-attendance-tracker-216606-216615/ci_run_flutter.sh test
```

Backend helpers:
- `make backend-db-up` -> starts Postgres
- `make backend-api-dev` -> runs Node API in dev
- `make backend-stack-up` -> Postgres + Node API together

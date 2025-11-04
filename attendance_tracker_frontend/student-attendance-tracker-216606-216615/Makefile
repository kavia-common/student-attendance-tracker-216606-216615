# PUBLIC_INTERFACE
# Monorepo Makefile to help CI run Flutter tasks from the correct root.

FLUTTER_DIR := student-attendance-tracker-216606-216615/attendance_tracker_frontend

.PHONY: flutter-root
flutter-root:
	@bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh

.PHONY: flutter-get
flutter-get:
	@cd $(FLUTTER_DIR) && flutter pub get

.PHONY: flutter-analyze
flutter-analyze:
	@cd $(FLUTTER_DIR) && flutter analyze

.PHONY: flutter-test
flutter-test:
	@cd $(FLUTTER_DIR) && CI=true flutter test -r expanded

# Backend helpers
.PHONY: backend-api-dev
backend-api-dev:
	@cd student-attendance-tracker-216606-216615/backend/node-api && npm ci && npm run dev

.PHONY: backend-db-up
backend-db-up:
	@cd student-attendance-tracker-216606-216615/backend && docker compose up -d

.PHONY: backend-stack-up
backend-stack-up:
	@cd student-attendance-tracker-216606-216615/backend && docker compose -f docker-compose.api.yml up -d --build

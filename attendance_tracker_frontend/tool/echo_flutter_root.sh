#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Echo the Flutter project root absolute path for CI tools that rely on shell scripts.

set -euo pipefail

# Resolve this script location, then print the project root path (parent directory).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
if [[ -f "$PROJECT_ROOT/pubspec.yaml" && -f "$PROJECT_ROOT/lib/main.dart" ]]; then
  echo "$PROJECT_ROOT"
  exit 0
else
  echo "Error: Not at Flutter root. Expected pubspec.yaml and lib/main.dart" >&2
  exit 2
fi

#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Verifies current directory is the Flutter project root.

set -euo pipefail

if [[ -f "pubspec.yaml" && -f "lib/main.dart" && -d "android" ]]; then
  echo "Flutter root verified at: $(pwd)"
  exit 0
else
  echo "Not at Flutter root. Expected pubspec.yaml and lib/main.dart here." >&2
  exit 2
fi

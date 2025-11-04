#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Echo the absolute path to the Flutter project root for CI tools.

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$ROOT/attendance_tracker_frontend"

#!/usr/bin/env bash
set -euo pipefail

environment="${1:-}"
case "$environment" in
  local|staging|production) ;;
  *) echo "Usage: $0 local|staging|production" >&2; exit 64 ;;
esac

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
source_file="$repo_root/config/ios/$environment.xcconfig"
target_file="$repo_root/apps/mobile/ios/Flutter/Environment.generated.xcconfig"
cp "$source_file" "$target_file"
echo "Selected iOS environment: $environment"

#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
case "${1:-}" in
  en|fa) edition=$1; shift ;;
  *) echo 'Usage: sudo bash uninstall.sh en|fa' >&2; exit 1 ;;
esac
exec bash "$script_dir/$edition-theme/uninstall.sh" "$@"

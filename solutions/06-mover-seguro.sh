#!/usr/bin/env bash

set -euo pipefail

source /course/scripts/lab-lib.sh

source_path="${1:?falta la ruta de origen}"
destination_path="${2:?falta la ruta de destino}"

require_lab_dir "$(dirname "$source_path")"
require_lab_dir "$(dirname "$destination_path")"
test -f "$source_path"

if [ "${DRY_RUN:-0}" = "1" ]; then
  printf 'dry-run: movería %q a %q\n' "$source_path" "$destination_path"
  exit 0
fi

mv -- "$source_path" "$destination_path"
printf 'movido=%s\n' "$destination_path"

#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:bash-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" -lc '
  source /course/scripts/lab-lib.sh
  work=$(new_lab_dir)
  trap "cleanup_lab_dir \"$work\"" EXIT
  printf dato >"$work/origen.txt"
  DRY_RUN=1 /course/solutions/06-mover-seguro.sh "$work/origen.txt" "$work/destino.txt"
  test -f "$work/origen.txt"
  /course/solutions/06-mover-seguro.sh "$work/origen.txt" "$work/destino.txt"
  test -f "$work/destino.txt"
')"

case "$output" in
  *"dry-run: movería"*"movido="*) ;;
  *)
    printf 'La solución de Bash no respetó dry-run y movimiento validado.\n' >&2
    exit 1
    ;;
esac

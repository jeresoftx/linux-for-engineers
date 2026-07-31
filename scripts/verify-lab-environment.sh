#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/lab-lib.sh"

if [ "$(id -u)" -eq 0 ]; then
  printf 'El laboratorio no debe ejecutarse como root.\n' >&2
  exit 1
fi

for command in bash awk curl find grep ip ps rg sed ss; do
  command -v "$command" >/dev/null
done

scratch="$(new_lab_dir)"
trap 'cleanup_lab_dir "$scratch"' EXIT
printf 'entorno aislado y verificable\n' >"$scratch/probe.txt"
test -f "$scratch/probe.txt"
printf 'Entorno listo: usuario=%s, raíz=%s\n' "$(id -un)" "$(lab_root)"

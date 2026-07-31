#!/usr/bin/env bash

set -euo pipefail

source /course/scripts/lab-lib.sh

work="$(new_lab_dir)"
trap 'cleanup_lab_dir "$work"' EXIT

umask 077
printf 'solo para el laboratorio\n' >"$work/privado.txt"
mode="$(stat --format '%a' "$work/privado.txt")"
test "$mode" = "600"

sleep 30 &
pid=$!
trap 'kill -TERM "$pid" 2>/dev/null || true; cleanup_lab_dir "$work"' EXIT

owner="$(ps -o user= -p "$pid" | tr -d ' ')"
test "$owner" = "learner"
kill -TERM "$pid"
wait "$pid" || test "$?" -eq 143

used="$(du -sb "$work" | cut -f1)"
available="$(df -B1 "$work" | awk 'NR == 2 { print $4 }')"
test "$used" -gt 0
test "$available" -gt 0

printf 'permiso=%s\n' "$mode"
printf 'proceso=terminado\n'
printf 'espacio=observado\n'

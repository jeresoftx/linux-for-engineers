#!/usr/bin/env bash

set -euo pipefail

source /course/scripts/lab-lib.sh

work="$(new_lab_dir)"
trap 'cleanup_lab_dir "$work"' EXIT

cat >"$work/eventos.log" <<'EOF'
INFO api request=100
WARN worker retry=1
INFO api request=101
INFO api request=102
WARN worker retry=2
EOF

rg --only-matching '^\S+' "$work/eventos.log" \
  | sort \
  | uniq -c \
  | awk '{ print $2 ":" $1 }' >"$work/niveles.txt"

rg --only-matching '^(INFO|WARN) \S+' "$work/eventos.log" \
  | cut -d' ' -f2 \
  | sort \
  | uniq -c \
  | awk '{ print $2 ":" $1 }' >"$work/servicios.txt"

test "$(cat "$work/niveles.txt")" = $'INFO:3\nWARN:2'
test "$(cat "$work/servicios.txt")" = $'api:3\nworker:2'

printf 'niveles=%s\n' "$(tr '\n' ',' <"$work/niveles.txt" | sed 's/,$//')"
printf 'servicios=%s\n' "$(tr '\n' ',' <"$work/servicios.txt" | sed 's/,$//')"

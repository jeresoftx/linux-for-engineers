#!/usr/bin/env bash

set -euo pipefail

fixture="/course/labs/fixtures/servicio-sintetico.log"
test -r "$fixture"

last_event="$(tail -n 1 "$fixture" | awk '{ print $4 }')"
warnings="$(rg --count '^.* level=WARN ' "$fixture")"
listening_line="$(rg 'event=listening' "$fixture")"

test "$last_event" = "event=ready"
test "$warnings" = "1"
test -n "$listening_line"

printf 'ultimo=%s\n' "$last_event"
printf 'advertencias=%s\n' "$warnings"
printf 'evidencia=lista\n'

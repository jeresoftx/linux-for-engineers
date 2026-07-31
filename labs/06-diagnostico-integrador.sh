#!/usr/bin/env bash

set -euo pipefail

source /course/scripts/lab-lib.sh

work="$(new_lab_dir)"
port=18082
log="$work/service.log"
state="$work/service.state"

cleanup() {
  if [ -n "${server_pid:-}" ]; then
    kill -TERM "$server_pid" 2>/dev/null || true
    wait "$server_pid" 2>/dev/null || true
  fi
  cleanup_lab_dir "$work"
}
trap cleanup EXIT

umask 077
printf 'state=ready\n' >"$state"
test "$(stat --format '%a' "$state")" = "600"

printf '%s\n' \
  'service=demo level=INFO event=starting' \
  "service=demo level=INFO event=listening port=$port" \
  'service=demo level=WARN event=retry request=42' \
  'service=demo level=INFO event=ready' >"$log"

nc -l -k 127.0.0.1 "$port" >>"$log" &
server_pid=$!

for _ in 1 2 3 4 5; do
  ss -ltn | awk '{ print $4 }' | grep -q ":$port$" && break
  sleep 1
done

ss -ltn | awk '{ print $4 }' | grep -q ":$port$"
printf 'health-check\n' | nc -N 127.0.0.1 "$port"
sleep 1

test "$(rg --count 'level=WARN' "$log")" = "1"
test "$(tail -n 1 "$log")" = "health-check"
test "$(cat "$state")" = "state=ready"

printf 'permiso=600\n'
printf 'socket=127.0.0.1:%s\n' "$port"
printf 'advertencias=1\n'
printf 'diagnostico=completo\n'

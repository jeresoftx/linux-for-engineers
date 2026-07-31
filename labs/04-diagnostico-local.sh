#!/usr/bin/env bash

set -euo pipefail

port=18080
log="$(mktemp)"

nc -l -k 127.0.0.1 "$port" >"$log" &
server_pid=$!
trap 'kill -TERM "$server_pid" 2>/dev/null || true; wait "$server_pid" 2>/dev/null || true; rm -f -- "$log"' EXIT

for _ in 1 2 3 4 5; do
  if ss -ltn | awk '{ print $4 }' | grep -q ":$port$"; then
    break
  fi
  sleep 1
done

ss -ltn | awk '{ print $4 }' | grep -q ":$port$"
printf 'salud\n' | nc -N 127.0.0.1 "$port"
sleep 1
test "$(cat "$log")" = "salud"

printf 'socket=127.0.0.1:%s\n' "$port"
printf 'peticion=recibida\n'

#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:logs-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/05-servicios-y-logs.sh)"

case "$output" in
  *"ultimo=event=ready"*"advertencias=1"*"evidencia=lista"*) ;;
  *)
    printf 'Los fixtures de servicio no conservaron su contrato observable.\n' >&2
    exit 1
    ;;
esac

#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:text-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/02-texto-y-busqueda.sh)"

case "$output" in
  *"niveles=INFO:3,WARN:2"*"servicios=api:3,worker:2"*) ;;
  *)
    printf 'El laboratorio de texto no produjo los conteos esperados.\n' >&2
    exit 1
    ;;
esac

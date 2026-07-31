#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:system-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/03-permisos-y-procesos.sh)"

case "$output" in
  *"permiso=600"*"proceso=terminado"*"espacio=observado"*) ;;
  *)
    printf 'El laboratorio de sistema no confirmó sus invariantes.\n' >&2
    exit 1
    ;;
esac

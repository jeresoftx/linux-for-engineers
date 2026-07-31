#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:files-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/01-archivos-y-navegacion.sh)"

case "$output" in
  *"enlace=salida/copia.txt"*"respaldo=presente"*) ;;
  *)
    printf 'El laboratorio de archivos no produjo su contrato esperado.\n' >&2
    exit 1
    ;;
esac

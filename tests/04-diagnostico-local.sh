#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:network-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/04-diagnostico-local.sh)"

case "$output" in
  *"socket=127.0.0.1:18080"*"peticion=recibida"*) ;;
  *)
    printf 'El laboratorio de red local no confirmó el socket y la petición.\n' >&2
    exit 1
    ;;
esac

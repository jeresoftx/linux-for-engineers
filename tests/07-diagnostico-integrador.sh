#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:integration-test"
docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/labs/06-diagnostico-integrador.sh)"

case "$output" in
  *"permiso=600"*"socket=127.0.0.1:18082"*"advertencias=1"*"diagnostico=completo"*) ;;
  *)
    printf 'El diagnóstico integrador no confirmó todas sus evidencias.\n' >&2
    exit 1
    ;;
esac

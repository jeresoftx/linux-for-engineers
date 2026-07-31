#!/usr/bin/env bash

set -euo pipefail

image="jeresoft-linux-for-engineers:test"

docker build --tag "$image" .
output="$(docker run --rm --network none "$image" /course/scripts/verify-lab-environment.sh)"

case "$output" in
  *"Entorno listo: usuario=learner"*) ;;
  *)
    printf 'No se confirmó el usuario aislado.\n' >&2
    exit 1
    ;;
esac

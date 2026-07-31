#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -eq 0 ]; then
  printf 'Uso: scripts/run-lab.sh <comando del laboratorio>\n' >&2
  exit 64
fi

docker build --tag jeresoft-linux-for-engineers:local .
docker run --rm --network none jeresoft-linux-for-engineers:local "$@"

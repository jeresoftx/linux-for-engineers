#!/usr/bin/env bash

# Completa este script sin usar eval ni rutas no validadas.
set -euo pipefail

source /course/scripts/lab-lib.sh

source_path="${1:?falta la ruta de origen}"
destination_path="${2:?falta la ruta de destino}"

# TODO: valida ambas rutas con require_lab_dir o una comprobación equivalente.
# TODO: implementa DRY_RUN=1 para mostrar la operación sin ejecutar mv.
printf 'pendiente: %s -> %s\n' "$source_path" "$destination_path"

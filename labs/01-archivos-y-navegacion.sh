#!/usr/bin/env bash

set -euo pipefail

source /course/scripts/lab-lib.sh

work="$(new_lab_dir)"
trap 'cleanup_lab_dir "$work"' EXIT

printf 'directorio=%s\n' "$work"
printf 'origen\n' >"$work/nota.txt"
mkdir "$work/entrada" "$work/salida"
mv "$work/nota.txt" "$work/entrada/nota.txt"
cp -- "$work/entrada/nota.txt" "$work/salida/copia.txt"
ln -s "salida/copia.txt" "$work/actual"

test -f "$work/entrada/nota.txt"
test -f "$work/salida/copia.txt"
test -L "$work/actual"

cp -- "$work/salida/copia.txt" "$work/salida/copia.txt.bak"
rm -- "$work/salida/copia.txt"
test -f "$work/salida/copia.txt.bak"

printf 'pwd=%s\n' "$(pwd)"
printf 'enlace=%s\n' "$(readlink "$work/actual")"
printf 'respaldo=presente\n'

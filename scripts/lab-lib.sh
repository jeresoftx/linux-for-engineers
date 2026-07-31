#!/usr/bin/env bash

set -euo pipefail

readonly LAB_ROOT_DEFAULT="/tmp/linux-for-engineers"

lab_root() {
  printf '%s\n' "${LAB_ROOT:-$LAB_ROOT_DEFAULT}"
}

prepare_lab_root() {
  local root
  root="$(lab_root)"

  case "$root" in
    /tmp/linux-for-engineers|/tmp/linux-for-engineers/*) ;;
    *)
      printf 'LAB_ROOT debe vivir bajo /tmp/linux-for-engineers: %s\n' "$root" >&2
      return 1
      ;;
  esac

  mkdir -p "$root"
}

new_lab_dir() {
  prepare_lab_root
  mktemp -d "$(lab_root)/lab.XXXXXX"
}

require_lab_dir() {
  local directory="$1"
  case "$directory" in
    "$(lab_root)"/*) ;;
    *)
      printf 'La ruta no pertenece al laboratorio: %s\n' "$directory" >&2
      return 1
      ;;
  esac
}

cleanup_lab_dir() {
  local directory="$1"
  require_lab_dir "$directory"
  rm -rf -- "$directory"
}

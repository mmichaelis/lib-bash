#!/usr/bin/env bash
###
### Include for printing help texts.
###
### Usage:
###
###   SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
###   readonly SCRIPT_DIR
###   source "${SCRIPT_DIR}/lib-bash/lib_help.sh"
###

# Guard variable to prevent multiple imports
if [[ -n "${LIB_HELP_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_HELP_SH_INCLUDED=1

LIB_HELP_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly LIB_HELP_PATH
LIB_HELP_DIR="$(dirname "${LIB_HELP_PATH}")"
readonly LIB_HELP_DIR
# shellcheck source=/dev/null
source "${LIB_HELP_DIR}/lib_init.sh"
# shellcheck source=/dev/null
source "${LIB_HELP_DIR}/lib_console.sh"

print_help() {
  local error_text="${1:-}"

  if [[ -n "${error_text}" ]]; then
    log_error "${error_text}"
    echo >&2
  fi

  if [[ -p /dev/stdin ]]; then
    while IFS= read -r line || [[ -n "${line}" ]]; do
      echo -e "${line}" >&2
    done
  else
    echo -e "${*}" >&2
  fi

  if [[ -n "${error_text}" ]]; then
    exit 1
  else
    exit 0
  fi
}

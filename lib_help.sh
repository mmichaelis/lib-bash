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

LIB_HELP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
readonly LIB_HELP_DIR
source "${LIB_HELP_DIR}/lib_init.sh"
source "${LIB_HELP_DIR}/lib_console.sh"

# ------------------------------------------------------------------------------
# Output Help Text
#
# Print the help text to the standard output. The help text can either be
# provided as a here document or as string. As optional first argument,
# an error text can be provided, which is printed to the standard error
# output before the help text (with one empty line in between).
#
# Arguments:
#   $1 - Error text (optional)
#   $2 - Help text (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Output Help Text
#
# Print the help text to the standard output. The help text can either be
# provided as a here document or as string. As optional first argument,
# an error text can be provided, which is printed to the standard error
# output before the help text (with one empty line in between).
#
# Arguments:
#   $1 - Error text
#   $2 - Help text
# Returns:
#   None
# ------------------------------------------------------------------------------
_help() {
  local error_text="${1?Error text must be provided}"

  shift

  if [[ -n "${error_text}" ]]; then
    error "${error_text}"
    echo
  fi

  if [[ -p /dev/stdin ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
      echo -e "${line}"
    done
  else
    echo -e "${*}"
  fi

  if [[ -n "${error_text}" ]]; then
    exit 1
  else
    exit 0
  fi
}

help() {
  _help "" "${@}"
}

error_and_help() {
  local error_text="${1?Error text must be provided}"
  shift
  _help "${error_text}" "${@}"
}

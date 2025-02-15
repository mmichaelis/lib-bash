#!/usr/bin/env bash
###
### A file for some initial Bash Scripting best practices.
###
### Usage:
###
###   SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
###   readonly SCRIPT_DIR
###   source "${SCRIPT_DIR}/lib-bash/lib_init.sh"
###

# Guard variable to prevent multiple imports
if [[ -n "${LIB_INIT_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_INIT_SH_INCLUDED=1

# Provide option to trigger debug output with different verbosity levels.
declare -ri DEBUG=${DEBUG:-0}
export DEBUG

# ------------------------------------------------------------------------------
# Bash Options
# ------------------------------------------------------------------------------

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes
### Call with `DEBUG=2 <command>.sh <file>` to enable verbose debug output
if ((DEBUG > 1)); then
  set -o xtrace # show expanded commands
else
  set +o xtrace # do not show expanded commands
fi

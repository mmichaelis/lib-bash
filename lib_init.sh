#!/usr/bin/env bash
# ==============================================================================
###
### # lib_init.sh
###
### A file for some initial Bash Scripting best practices. It applies the
### following settings:
###
### * `errexit`: Abort on nonzero exit status
### * `nounset`: Abort on unbound variable
### * `pipefail`: Don't hide errors within pipes
### * `xtrace`: Show expanded commands if `DEBUG` is set to 2. Set to 1 for
###   more verbose output.
###
### **Usage**:
###
### ```bash
### MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
### SCRIPT_DIR="$(dirname "${MY_PATH}")"
### readonly MY_PATH
### readonly SCRIPT_DIR
### readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
### source "${LIB_BASH_DIR}/lib_init.sh"
### ```
###
# ==============================================================================

# Guard variable to prevent multiple imports
if [[ -n "${LIB_INIT_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_INIT_SH_INCLUDED=1

# ------------------------------------------------------------------------------
###
### ## Constants
###
# ------------------------------------------------------------------------------

### * `DEBUG`: Provide option to trigger debug output with different verbosity
###   levels.
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

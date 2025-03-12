#!/usr/bin/env bash
# ==============================================================================
###
### # lib_scriptinfo.sh
###
### Include for script information functions.
###
### **Usage**:
###
### ```bash
### MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
### SCRIPT_DIR="$(dirname "${MY_PATH}")"
### readonly MY_PATH
### readonly SCRIPT_DIR
### readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
### source "${LIB_BASH_DIR}/lib_scriptinfo.sh"
### ```
###
# ==============================================================================

# Guard variable to prevent multiple imports
if [[ -n "${LIB_SCRIPTINFO_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_SCRIPTINFO_SH_INCLUDED=1

LIB_SCRIPTINFO_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly LIB_SCRIPTINFO_PATH
LIB_SCRIPTINFO_DIR="$(dirname "${LIB_SCRIPTINFO_PATH}")"
readonly LIB_SCRIPTINFO_DIR
# shellcheck source=/dev/null
source "${LIB_SCRIPTINFO_DIR}/lib_init.sh"

# ------------------------------------------------------------------------------
###
### ## Functions
###
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
###
### ### get_script_name
###
### Get script name (without path, with extension).
###
### * **Arguments**: _None_
### * **Returns**: The script name.
###
# ------------------------------------------------------------------------------
function get_script_name() {
  echo "${0##*/}"
}

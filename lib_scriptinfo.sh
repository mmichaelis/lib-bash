#!/usr/bin/env bash
###
### Include for script information functions.
###
### Usage:
###
###   SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
###   readonly SCRIPT_DIR
###   source "${SCRIPT_DIR}/lib-bash/lib_scriptinfo.sh"
###

# Guard variable to prevent multiple imports
if [[ -n "${LIB_SCRIPTINFO_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_SCRIPTINFO_SH_INCLUDED=1

LIB_SCRIPTINFO_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
readonly LIB_SCRIPTINFO_DIR
# shellcheck source=/dev/null
source "${LIB_SCRIPTINFO_DIR}/lib_init.sh"

# ------------------------------------------------------------------------------
# Get script name (without path, with extension).
#
# Arguments:
#   None
# Returns:
#   The script name.
# ------------------------------------------------------------------------------
function get_script_name() {
  echo "${0##*/}"
}

#!/usr/bin/env bash
###
### Demo for GNU Tools Compatibility Layer
###

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
declare -r SCRIPT_DIR
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../lib_gnucompat.sh"

# Function to output the path and GNU status of a command
function output_command_info() {
  local cmd_var_name="${1}"
  local cmd="${!cmd_var_name}"
  local cmd_path
  cmd_path=$(command -v "${cmd}")
  local gnu_status
  if is_gnu "${cmd}"; then
    gnu_status="Yes"
  else
    gnu_status="No"
  fi
  echo "${cmd_var_name}: ${cmd_path} (GNU? ${gnu_status})"
}

# Output information for each command
output_command_info "SED"
output_command_info "AWK"
output_command_info "GREP"
output_command_info "FIND"
output_command_info "SORT"
output_command_info "TAR"
output_command_info "DATE"
output_command_info "XARGS"
output_command_info "CUT"
output_command_info "HEAD"
output_command_info "TAIL"
output_command_info "TR"
output_command_info "UNIQ"
output_command_info "WC"
output_command_info "DIFF"

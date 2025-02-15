#!/usr/bin/env bash
###
### Include for console support.
###
### Usage:
###
###   SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
###   readonly SCRIPT_DIR
###   source "${SCRIPT_DIR}/lib-bash/lib_console.sh"
###

# Guard variable to prevent multiple imports
if [[ -n "${LIB_CONSOLE_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_CONSOLE_SH_INCLUDED=1

# Initialize DEBUG variable if not already set
: "${DEBUG:=0}"

LIB_CONSOLE_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly LIB_CONSOLE_PATH
LIB_CONSOLE_DIR="$(dirname "${LIB_CONSOLE_PATH}")"
readonly LIB_CONSOLE_DIR
# shellcheck source=/dev/null
source "${LIB_CONSOLE_DIR}/lib_init.sh"

# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

# Foreground Colors
readonly COLOR_RESET="\033[0m"
readonly COLOR_BLACK="\033[0;30m"
readonly COLOR_RED="\033[0;31m"
readonly COLOR_GREEN="\033[0;32m"
readonly COLOR_YELLOW="\033[0;33m"
readonly COLOR_BLUE="\033[0;34m"
readonly COLOR_MAGENTA="\033[0;35m"
readonly COLOR_CYAN="\033[0;36m"
readonly COLOR_WHITE="\033[0;37m"
readonly COLOR_GRAY="\033[1;30m"
readonly COLOR_LIGHT_RED="\033[1;31m"
readonly COLOR_LIGHT_GREEN="\033[1;32m"
readonly COLOR_LIGHT_YELLOW="\033[1;33m"
readonly COLOR_LIGHT_BLUE="\033[1;34m"
readonly COLOR_LIGHT_MAGENTA="\033[1;35m"
readonly COLOR_LIGHT_CYAN="\033[1;36m"
readonly COLOR_LIGHT_WHITE="\033[1;37m"

# Background Colors
readonly COLOR_BG_BLACK="\033[40m"
readonly COLOR_BG_RED="\033[41m"
readonly COLOR_BG_GREEN="\033[42m"
readonly COLOR_BG_YELLOW="\033[43m"
readonly COLOR_BG_BLUE="\033[44m"
readonly COLOR_BG_MAGENTA="\033[45m"
readonly COLOR_BG_CYAN="\033[46m"
readonly COLOR_BG_WHITE="\033[47m"

# Export Color and Color Background Constants

export COLOR_RESET
export COLOR_BLACK
export COLOR_RED
export COLOR_GREEN
export COLOR_YELLOW
export COLOR_BLUE
export COLOR_MAGENTA
export COLOR_CYAN
export COLOR_WHITE
export COLOR_GRAY
export COLOR_LIGHT_RED
export COLOR_LIGHT_GREEN
export COLOR_LIGHT_YELLOW
export COLOR_LIGHT_BLUE
export COLOR_LIGHT_MAGENTA
export COLOR_LIGHT_CYAN
export COLOR_LIGHT_WHITE

export COLOR_BG_BLACK
export COLOR_BG_RED
export COLOR_BG_GREEN
export COLOR_BG_YELLOW
export COLOR_BG_BLUE
export COLOR_BG_MAGENTA
export COLOR_BG_CYAN
export COLOR_BG_WHITE

# ------------------------------------------------------------------------------
# Logging
#
# All logging functions to output information to STDERR. STDERR is preferred,
# as it is not affected by the output redirection of the script, thus, the
# desired standard output can be redirected to a file or another command.
#
# References:
#   - https://gkarthiks.github.io/quick-commands-cheat-sheet/bash_command.html
#   - https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# General logging function.
#
# The _log function is used to output log messages with a specified prefix and
# suffix. It can handle both direct function calls and piped input.
#
# Arguments:
#   $1 - The prefix to use for the log message.
#   $2 - The suffix to use for the log message.
#   $3 - The message to print (optional).
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function _log() {
  local prefix="$1"
  local suffix="$2"
  shift 2

  if [[ -p /dev/stdin ]]; then
    while IFS= read -r line || [[ -n "${line}" ]]; do
      echo -e "${prefix}${line}${suffix}" >&2
    done
  else
    echo -e "${prefix}${*}${suffix}" >&2
  fi
}

# ------------------------------------------------------------------------------
# Output debug message.
#
# The debug function is used to output debug information. It is only printed if
# the DEBUG variable is set to a value greater than 0.
#
# If the standard output supports color, the debug information is printed in
# gray color. Otherwise, the debug information is printed without color.
#
# Arguments:
#   The message to print.
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function debug() {
  if ((DEBUG > 0)); then
    if [[ -t 2 ]]; then
      _log "${COLOR_GRAY}[DEBUG] " "${COLOR_RESET}" "$@"
    else
      _log "[DEBUG] " "" "$@"
    fi
  else
    # Consume and discard the input to prevent SIGPIPE
    if [[ -p /dev/stdin ]]; then
      while IFS= read -r line; do :; done
    fi
  fi
}

# ------------------------------------------------------------------------------
# Output information message.
#
# The info function is used to output information messages. No extra color is
# used for the information message.
#
# Arguments:
#   The message to print.
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function info() {
  _log "[INFO] " "" "$@"
}

# ------------------------------------------------------------------------------
# Output warning message.
#
# The warning function is used to output warning messages. The warning message
# is printed in yellow color.
#
# Arguments:
#   The message to print.
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function warn() {
  if [[ -t 2 ]]; then
    _log "${COLOR_LIGHT_YELLOW}[WARNING] " "${COLOR_RESET}" "$@"
  else
    _log "[WARNING] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
# Output error message.
#
# The error function is used to output error messages. The error message is
# printed in red color.
#
# Arguments:
#   The message to print.
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function error() {
  if [[ -t 2 ]]; then
    _log "${COLOR_LIGHT_RED}[ERROR] " "${COLOR_RESET}" "$@"
  else
    _log "[ERROR] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
# Output error message.
#
# The error function is used to output error messages. The error message is
# printed with dark red background and bright yellow color.
#
# Arguments:
#   The message to print.
# Returns:
#   None
# Output:
#   The message is printed to STDERR.
# ------------------------------------------------------------------------------
function fatal() {
  if [[ -t 2 ]]; then
    _log "${COLOR_BG_RED}${COLOR_LIGHT_YELLOW}[FATAL] " "${COLOR_RESET}" "$@"
  else
    _log "[FATAL] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
# Alternative to `cat` that also processes colored input.
#
# Arguments:
#   None
# Returns:
#   None
# Output:
#   The colored input is printed to STDOUT.
function ccat() {
  local line
  while IFS= read -r line || [[ -n "${line}" ]]; do
    echo -e "${line}"
  done
}

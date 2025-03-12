#!/usr/bin/env bash
# ==============================================================================
###
### # lib_console.sh
###
### Include for console support.
###
### **Usage**:
###
### ```bash
### MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
### SCRIPT_DIR="$(dirname "${MY_PATH}")"
### readonly MY_PATH
### readonly SCRIPT_DIR
### readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
### source "${LIB_BASH_DIR}/lib_console.sh"
### ```
###
# ==============================================================================

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
###
### ## Color Constants
###
# ------------------------------------------------------------------------------

###
### ### Foreground Colors
###

### * `COLOR_RESET`: Reset the color.
readonly COLOR_RESET="\033[0m"
### * `COLOR_BLACK`: Black color.
readonly COLOR_BLACK="\033[0;30m"
### * `COLOR_RED`: Red color.
readonly COLOR_RED="\033[0;31m"
### * `COLOR_GREEN`: Green color.
readonly COLOR_GREEN="\033[0;32m"
### * `COLOR_YELLOW`: Yellow color.
readonly COLOR_YELLOW="\033[0;33m"
### * `COLOR_BLUE`: Blue color.
readonly COLOR_BLUE="\033[0;34m"
### * `COLOR_MAGENTA`: Magenta color.
readonly COLOR_MAGENTA="\033[0;35m"
### * `COLOR_CYAN`: Cyan color.
readonly COLOR_CYAN="\033[0;36m"
### * `COLOR_WHITE`: White color.
readonly COLOR_WHITE="\033[0;37m"
### * `COLOR_GRAY`: Gray color.
readonly COLOR_GRAY="\033[1;30m"
### * `COLOR_LIGHT_RED`: Light red color.
readonly COLOR_LIGHT_RED="\033[1;31m"
### * `COLOR_LIGHT_GREEN`: Light green color.
readonly COLOR_LIGHT_GREEN="\033[1;32m"
### * `COLOR_LIGHT_YELLOW`: Light yellow color.
readonly COLOR_LIGHT_YELLOW="\033[1;33m"
### * `COLOR_LIGHT_BLUE`: Light blue color.
readonly COLOR_LIGHT_BLUE="\033[1;34m"
### * `COLOR_LIGHT_MAGENTA`: Light magenta color.
readonly COLOR_LIGHT_MAGENTA="\033[1;35m"
### * `COLOR_LIGHT_CYAN`: Light cyan color.
readonly COLOR_LIGHT_CYAN="\033[1;36m"
### * `COLOR_LIGHT_WHITE`: Light white color.
readonly COLOR_LIGHT_WHITE="\033[1;37m"

###
### ### Background Colors
###

### * `COLOR_BG_BLACK`: Black background color.
readonly COLOR_BG_BLACK="\033[40m"
### * `COLOR_BG_RED`: Red background color.
readonly COLOR_BG_RED="\033[41m"
### * `COLOR_BG_GREEN`: Green background color.
readonly COLOR_BG_GREEN="\033[42m"
### * `COLOR_BG_YELLOW`: Yellow background color.
readonly COLOR_BG_YELLOW="\033[43m"
### * `COLOR_BG_BLUE`: Blue background color.
readonly COLOR_BG_BLUE="\033[44m"
### * `COLOR_BG_MAGENTA`: Magenta background color.
readonly COLOR_BG_MAGENTA="\033[45m"
### * `COLOR_BG_CYAN`: Cyan background color.
readonly COLOR_BG_CYAN="\033[46m"
### * `COLOR_BG_WHITE`: White background color.
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
###
### ## Logging
###
### All logging functions to output information to STDERR. STDERR is preferred,
### as it is not affected by the output redirection of the script, thus, the
### desired standard output can be redirected to a file or another command.
###
# ------------------------------------------------------------------------------
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
  local prefix="${1}"
  local suffix="${2}"
  local message
  message="${3:-$(</dev/stdin)}"

  if [[ -n "${message}" ]]; then
    #    echo -e "${prefix}${message}${suffix}" >&2
    # Iterate over lines and apply pre- and suffix to each line
    while IFS= read -r line || [[ -n "${line}" ]]; do
      echo -e "${prefix}${line}${suffix}" >&2
    done <<<"${message}"
  fi
}

# ------------------------------------------------------------------------------
###
### ### log_debug
###
### Output debug message.
###
### The function is used to output debug information. It is only printed
### if the `DEBUG` variable is set to a value greater than 0 (zero).
###
### If the standard output supports color, the debug information is printed in
### gray color. Otherwise, the debug information is printed without color.
###
### **Usage**:
###
### ```bash
### log_debug "Only show if DEBUG=1 (or more)"
### grep "pattern" file.txt | log_debug
### ```
###
# ------------------------------------------------------------------------------
function log_debug() {
  if ((DEBUG > 0)); then
    if [[ -t 2 ]]; then
      _log "${COLOR_GRAY}[DEBUG] " "${COLOR_RESET}" "$@"
    else
      _log "[DEBUG] " "" "$@"
    fi
  else
    # Consume and discard the input to prevent SIGPIPE. Only do this, if no
    # arguments are given.
    if [[ "${#}" -eq 0 ]]; then
      cat >/dev/null
    fi
  fi
}

# ------------------------------------------------------------------------------
###
### ### log_info
###
### Output information message.
###
### The function is used to output information messages. No extra color is
### used for the information message.
###
### **Usage**:
###
### ```bash
### log_info "An informational message."
### grep "pattern" file.txt | log_info
### ```
###
# ------------------------------------------------------------------------------
function log_info() {
  _log "[INFO] " "" "$@"
}

# ------------------------------------------------------------------------------
###
### ### log_warn
###
### Output warning message.
###
### The function is used to output warning messages. The warning message
### is printed in yellow color.
###
### **Usage**:
###
### ```bash
### log_warn "A warning notice."
### grep "pattern" file.txt | log_warn
### ```
###
# ------------------------------------------------------------------------------
function log_warn() {
  if [[ -t 2 ]]; then
    _log "${COLOR_LIGHT_YELLOW}[WARNING] " "${COLOR_RESET}" "$@"
  else
    _log "[WARNING] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
###
### ### log_error
###
### Output error message.
###
### The function is used to output error messages. The error message is
### printed in red color.
###
### **Usage**:
###
### ```bash
### log_error "An error."
### grep "pattern" file.txt | log_error
### ```
###
# ------------------------------------------------------------------------------
function log_error() {
  if [[ -t 2 ]]; then
    _log "${COLOR_LIGHT_RED}[ERROR] " "${COLOR_RESET}" "$@"
  else
    _log "[ERROR] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
###
### ### log_fatal
###
### Output a fatal error message.
###
### The function is used to output error messages. The error message is
### printed with dark red background and bright yellow color.
###
### **Usage**:
###
### ```bash
### log_fatal "A fatal error."
### grep "pattern" file.txt | log_fatal
### ```
###
# ------------------------------------------------------------------------------
function log_fatal() {
  if [[ -t 2 ]]; then
    _log "${COLOR_BG_RED}${COLOR_LIGHT_YELLOW}[FATAL] " "${COLOR_RESET}" "$@"
  else
    _log "[FATAL] " "" "$@"
  fi
}

# ------------------------------------------------------------------------------
###
### ### ccat
###
### Alternative to `cat` that also processes colored input.
###
### **Usage**:
###
### ```bash
### ccat <<EOF
### ${COLOR_RED}This is red text.${COLOR_RESET}
### ${COLOR_YELLOW}This is yellow text.${COLOR_RESET}
### EOF
### ```
###
# ------------------------------------------------------------------------------
function ccat() {
  local content="${1:-$(</dev/stdin)}"
  echo -e "${content}"
}

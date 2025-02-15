#!/usr/bin/env bash
###
### Usage Demo for the console support library.
###

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
declare -r SCRIPT_DIR
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../lib_console.sh"

# ------------------------------------------------------------------------------
# Function Usage
# ------------------------------------------------------------------------------

log_debug "This is a debug message."
log_info "This is an info message."
log_warn "This is a warning message."
log_error "This is an error message."
log_fatal "This is a fatal message."

# ------------------------------------------------------------------------------
# Pipe Usage (Single Line)
# ------------------------------------------------------------------------------

echo "This is a debug message." | log_debug
echo "This is an info message." | log_info
echo "This is a warning message." | log_warn
echo "This is an error message." | log_error
echo "This is a fatal message." | log_fatal

# ------------------------------------------------------------------------------
# Pipe Usage (Multi-Line)
# ------------------------------------------------------------------------------

cat << EOF | log_debug
This is a debug message.
This is the second line.
EOF

cat << EOF | log_info
This is an info message.
This is the second line.
EOF

cat << EOF | log_warn
This is a warning message.
This is the second line.
EOF

cat << EOF | log_error
This is an error message.
This is the second line.
EOF

cat << EOF | log_fatal
This is a fatal message.
This is the second line.
EOF

# ------------------------------------------------------------------------------
# Usage Examples Color Constants
# ------------------------------------------------------------------------------

ccat << EOF
${COLOR_BLACK}This is black text.${COLOR_RESET}
${COLOR_RED}This is red text.${COLOR_RESET}
${COLOR_GREEN}This is green text.${COLOR_RESET}
${COLOR_YELLOW}This is yellow text.${COLOR_RESET}
${COLOR_BLUE}This is blue text.${COLOR_RESET}
${COLOR_MAGENTA}This is magenta text.${COLOR_RESET}
${COLOR_CYAN}This is cyan text.${COLOR_RESET}
${COLOR_WHITE}This is white text.${COLOR_RESET}
EOF

# ------------------------------------------------------------------------------
# Usage Examples Color Background Constants
# ------------------------------------------------------------------------------

ccat << EOF
${COLOR_BG_BLACK}This is black background.${COLOR_RESET}
${COLOR_BG_RED}This is red background.${COLOR_RESET}
${COLOR_BG_GREEN}This is green background.${COLOR_RESET}
${COLOR_BG_YELLOW}This is yellow background.${COLOR_RESET}
${COLOR_BG_BLUE}This is blue background.${COLOR_RESET}
${COLOR_BG_MAGENTA}This is magenta background.${COLOR_RESET}
${COLOR_BG_CYAN}This is cyan background.${COLOR_RESET}
${COLOR_BG_WHITE}This is white background.${COLOR_RESET}
EOF

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

debug "This is a debug message."
info "This is an info message."
warn "This is a warning message."
error "This is an error message."
fatal "This is a fatal message."

# ------------------------------------------------------------------------------
# Pipe Usage (Single Line)
# ------------------------------------------------------------------------------

echo "This is a debug message." | debug
echo "This is an info message." | info
echo "This is a warning message." | warn
echo "This is an error message." | error
echo "This is a fatal message." | fatal

# ------------------------------------------------------------------------------
# Pipe Usage (Multi-Line)
# ------------------------------------------------------------------------------

cat <<EOF | debug
This is a debug message.
This is the second line.
EOF

cat <<EOF | info
This is an info message.
This is the second line.
EOF

cat <<EOF | warn
This is a warning message.
This is the second line.
EOF

cat <<EOF | error
This is an error message.
This is the second line.
EOF

cat <<EOF | fatal
This is a fatal message.
This is the second line.
EOF

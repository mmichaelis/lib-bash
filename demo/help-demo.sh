#!/usr/bin/env bash
###
### Usage Demo for the help support library.
###

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
declare -r SCRIPT_DIR
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../lib_help.sh"

# For demo purpose don't exit on error
set +o errexit

# ------------------------------------------------------------------------------
# Function Usage
# ------------------------------------------------------------------------------

(help "Just some help text.")
(error_and_help "A demo error occurred." "Just some help text.")

# ------------------------------------------------------------------------------
# Pipe Usage (Single Line)
# ------------------------------------------------------------------------------

(echo "Just some help text." | help)
(echo "Just some help text." | error_and_help "A demo error occurred.")

# ------------------------------------------------------------------------------
# Pipe Usage (Multi-Line)
# ------------------------------------------------------------------------------

cat <<EOF | (help)
Just some help text.
This is the second line.
EOF

cat <<EOF | (error_and_help "A demo error occurred.")
Just some help text.
This is the second line.
EOF

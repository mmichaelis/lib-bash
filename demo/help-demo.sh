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

TERM_WIDTH="$(tput cols)"
SEPARATOR="$(printf "%${TERM_WIDTH}s" | tr ' ' '-')"
readonly TERM_WIDTH
readonly SEPARATOR

# ------------------------------------------------------------------------------
# Pipe Usage (Single Line)
# ------------------------------------------------------------------------------

echo "${SEPARATOR}"

(echo "Help for pipe usage without error." | help)

echo "${SEPARATOR}"

(echo "Help for pipe usage with error." | help "Example error message.")

# ------------------------------------------------------------------------------
# Pipe Usage (Multi-Line)
# ------------------------------------------------------------------------------

echo "${SEPARATOR}"

cat <<EOF | (help)
Help for HERE document pipe usage without error.
Using indirection via 'cat'.
EOF

echo "${SEPARATOR}"

cat <<EOF | (help "Example error message.")
Help for HERE document pipe usage with error.
Using indirection via 'cat'.
EOF

echo "${SEPARATOR}"

(
  help <<EOF
Help for HERE document pipe usage without error.
Using direct call.
EOF
)

echo "${SEPARATOR}"

(
help "Example error message" << EOF
Help for HERE document pipe usage with error.
Using direct call.
EOF
)

echo "${SEPARATOR}"

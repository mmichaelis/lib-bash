#!/usr/bin/env bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# Check if shfmt is installed
if ! command -v shfmt &> /dev/null; then
  echo "Error: shfmt is not installed." >&2
  exit 1
fi

MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly SCRIPT_DIR

readonly LIB_DIR="${SCRIPT_DIR}/.."

# Function to check formatting
check_format() {
  cd "${LIB_DIR}"
  shfmt --diff .
}

# Function to fix formatting
fix_format() {
  cd "${LIB_DIR}"
  shfmt --write .
}

# Main script
if [[ "${1:-}" == "fix" ]]; then
  fix_format
else
  check_format
fi

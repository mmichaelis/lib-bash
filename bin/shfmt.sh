#!/usr/bin/env bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# Check if shfmt is installed
if ! command -v shfmt &>/dev/null; then
  echo "Error: shfmt is not installed." >&2
  exit 1
fi

MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly SCRIPT_DIR

readonly LIB_DIR="${SCRIPT_DIR}/.."
# Find all shell scripts in the directory
LIBS=$(find "${LIB_DIR}" -type f -name "*.sh" -not -path "${LIB_DIR}/tests/bats/*")
readonly LIBS

# Function to check formatting
check_format() {
  cd "${LIB_DIR}"
  shfmt --diff .
  #  for file in ${LIBS}; do
  #    if ! shfmt --diff --filename "${file}"; then
  #      echo "File ${file} is not properly formatted."
  #      echo "Please install shfmt. Fore more information, visit: https://github.com/mvdan/sh" >&2
  #      return 1
  #    fi
  #  done
}

# Function to fix formatting
fix_format() {
  for file in ${LIBS}; do
    shfmt --write --filename "${file}"
  done
}

# Main script
if [[ "${1:-}" == "fix" ]]; then
  fix_format
else
  check_format
fi

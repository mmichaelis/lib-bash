#!/usr/bin/env bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# Check if shellcheck is installed
if ! command -v shellcheck &> /dev/null; then
  echo "Error: shellcheck is not installed." >&2
  echo "Please install shellcheck. For more information, visit: https://www.shellcheck.net/" >&2
  exit 1
fi

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}" || true)")"
readonly SCRIPT_DIR

LIB_DIR="${SCRIPT_DIR}/.."
# Find all shell scripts in the directory
LIBS=$(find "${LIB_DIR}" -name "*.sh")

# Run shellcheck on each script
for script in ${LIBS}; do
  echo "Linting ${script}"
  if ! shellcheck "${script}"; then
    echo "Linting failed for ${script}"
    exit 1
  fi
done

echo "All scripts passed shellcheck"

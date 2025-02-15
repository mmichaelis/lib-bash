#!/usr/bin/env bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# Check if bats is installed
if ! command -v bats &> /dev/null; then
  echo "Error: bats is not installed." >&2
  echo "Please install bats. For more information, visit: https://github.com/bats-core/bats-core#installation" >&2
  exit 1
fi

# Directory containing the tests
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
MY_DIR="$(dirname "${MY_PATH}")"
readonly MY_DIR
TEST_DIR="${MY_DIR}/../tests"
readonly TEST_DIR

# Run bats tests
echo "Running Bats tests in ${TEST_DIR}"
bats "${TEST_DIR}"

echo "All tests passed"

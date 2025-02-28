#!/usr/bin/env bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# Directory containing the tests
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
MY_DIR="$(dirname "${MY_PATH}")"
readonly MY_DIR
readonly TEST_DIR="${MY_DIR}/../tests"
readonly BATS_DIR="${MY_DIR}/../lib/test/bats/core"
readonly BATS_BIN_DIR="${BATS_DIR}/bin"
readonly BATS_EXECUTABLE="${BATS_BIN_DIR}/bats"

# Run bats tests
echo "Running Bats tests in ${TEST_DIR}"
"${BATS_EXECUTABLE}" "${TEST_DIR}"

echo "All tests passed"

#!/usr/bin/env bash
###
### Script to generate Markdown documentation for all library files.
###
### Invokes `doc-single.sh` for each library file `lib_*.sh`. The output is
### written to `docs/lib`. Before processing each library file, the target
### directory is cleared and ensures that it exists.
###
### Usage:
###
### ```bash
### doc.sh
### ```
###

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly DOC_SINGLE="${SCRIPT_DIR}/doc-single.sh"
readonly LIB_BASH_DIR="${SCRIPT_DIR}/.."
readonly LIB_DOCS_DIR="${SCRIPT_DIR}/../docs/_lib"

function main() {
  rm -rf "${LIB_DOCS_DIR}"
  mkdir -p "${LIB_DOCS_DIR}"

  local lib

  for lib in "${LIB_BASH_DIR}"/lib_*.sh; do
    local lib_name
    lib_name="$(basename "${lib}")"
    local target="${LIB_DOCS_DIR}/${lib_name%.sh}.md"
    "${DOC_SINGLE}" "${lib}" >"${target}"
  done
}

main "${@}"

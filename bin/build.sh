#!/usr/bin/env bash
###
### Script to build this project.
###
### Creates a ZIP and TAR.GZ archive of the project, that includes the
### relevant artifacts for local usage (if not using as Git submodule or
### subtree).
###
### The archive will contain:
###
### - .version
### - README.md
### - UNLICENSE (thus, the license)
### - lib_*.sh files
###
### within a directory named `lib-bash` within that archive.
###
### The archived will be named `lib-bash-<version>.zip` and
### `lib-bash-<version>.tar.gz`.
###
### Directories:
###
### - build/ - working directory for the build process
### - dist/ - final location of the archives
###

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly SCRIPT_DIR

WORKSPACE_ROOT="$(realpath "${SCRIPT_DIR}/..")"
readonly WORKSPACE_ROOT
declare -r VERSION_FILE=".version"
declare -r README_FILE="README.md"
declare -r LICENSE_FILE="UNLICENSE"
declare -r BUILD_DIR="build"
declare -r DIST_DIR="dist"

function main() {
  local result_format="${1:-}"
  local version=""
  local zip_file=""
  local tar_file=""

  # Validate dependencies
  if ! command -v zip &>/dev/null; then
    echo "Error: 'zip' is required. Please install it first."
    exit 1
  fi

  if ! command -v tar &>/dev/null; then
    echo "Error: 'tar' is required. Please install it first."
    exit 1
  fi

  cd "${WORKSPACE_ROOT}"

  # Fail if version file is missing
  if [[ ! -f "${VERSION_FILE}" ]]; then
    echo "Error: Missing version file '${VERSION_FILE}'."
    exit 1
  fi

  # Read the version from the file
  version=$(<"${VERSION_FILE}")

  zip_file="${DIST_DIR}/lib-bash-${version}.zip"
  tar_file="${DIST_DIR}/lib-bash-${version}.tar.gz"

  # Validate the README file
  if [[ ! -f "${README_FILE}" ]]; then
    echo "Error: Missing README file '${README_FILE}'."
    exit 1
  fi

  # Validate the LICENSE file
  if [[ ! -f "${LICENSE_FILE}" ]]; then
    echo "Error: Missing LICENSE file '${LICENSE_FILE}'."
    exit 1
  fi

  # Create the build directory
  rm -rf "${BUILD_DIR}"
  mkdir -p "${BUILD_DIR}/lib-bash"

  # Copy the files to the build directory
  cp "${VERSION_FILE}" "${BUILD_DIR}/lib-bash"
  cp "${README_FILE}" "${BUILD_DIR}/lib-bash"
  cp "${LICENSE_FILE}" "${BUILD_DIR}/lib-bash"

  # Copy the library files to the build directory
  cp "lib_"*.sh "${BUILD_DIR}/lib-bash"

  rm -rf "${DIST_DIR}"
  mkdir -p "${DIST_DIR}"

  # Create the ZIP archive
  rm -f "${zip_file}"
  (cd "${BUILD_DIR}" && zip -r9 "../${zip_file}" lib-bash &>/dev/null)

  # Create the TAR.GZ archive
  rm -f "${tar_file}"
  tar -czf "${tar_file}" -C "${BUILD_DIR}" lib-bash

  if [[ "${result_format}" == "json" ]]; then
    echo "{"
    echo "  \"zip\": \"${zip_file}\","
    echo "  \"tar\": \"${tar_file}\""
    echo "}"
  else
    echo "Build successful."
    echo "ZIP archive: ${zip_file}"
    echo "TAR.GZ archive: ${tar_file}"
  fi
}

main "${@}"

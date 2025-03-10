#!/usr/bin/env bash
###
### Script read and update the version of the project.
###
### Usage:
###   bin/version.sh
###   bin/version.sh <version>
###   bin/version.sh major
###   bin/version.sh minor
###   bin/version.sh patch
###

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly MY_PATH
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly SCRIPT_DIR

readonly VERSION_FILE="${SCRIPT_DIR}/../.version"

function main() {
  local version_argument="${1:-}"
  local version=""
  local major=0
  local minor=0
  local patch=0

  # Read the version from the file
  if [[ -f "${VERSION_FILE}" ]]; then
    version=$(<"${VERSION_FILE}")
    major=$(echo "${version}" | cut -d. -f1)
    minor=$(echo "${version}" | cut -d. -f2)
    patch=$(echo "${version}" | cut -d. -f3)
  fi

  # Increment the version number
  case "${version_argument}" in
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  patch)
    patch=$((patch + 1))
    ;;
  "")
    # No arguments provided, keep the version number as is
    ;;
  *)
    # Set the version number
    major=$(echo "${1}" | cut -d. -f1)
    minor=$(echo "${1}" | cut -d. -f2)
    patch=$(echo "${1}" | cut -d. -f3)
    ;;
  esac

  if [[ -z "${version_argument}" ]]; then
    echo "Current version: ${version}"
  else
    echo "${major}.${minor}.${patch}" >"${VERSION_FILE}"
    echo "New version: ${major}.${minor}.${patch}"
  fi
}

main "${@}"

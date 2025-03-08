#!/usr/bin/env bash
###
### Script to install GNU tools (typically on macOS).
###
### Requires `brew` to be installed.
###

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

### GNU Tools to install
###
### References:
### - https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
### - https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
### https://github.com/asantra1/macOS-gnu-tools/blob/master/gnu-cmd.sh

declare -a GNU_TOOLS=(
  "binutils"
  "coreutils"
  "diffutils"
  "ed"
  "findutils"
  "gawk"
  "gnu-indent"
  "gnu-sed"
  "gnu-tar"
  "gnu-which"
  "gnutls"
  "grep"
  "gzip"
  "screen"
  "watch"
  "wdiff"
  "wget"
)

### GNU Tools to update
###
### Some GNU tools are already installed on macOS, but may be outdated.
### This list contains the tools that should be updated.
###
### References:
### - https://github.com/asantra1/macOS-gnu-tools/blob/master/gnu-cmd.sh

declare -a GNU_TOOLS_TO_UPDATE=(
  "bash"
  "emacs"
  "gpatch"
  "m4"
  "make"
  "nano"
)

### Validate `brew` is installed
if ! command -v brew &>/dev/null; then
  echo "Error: 'brew' is required. Please install it first."
  exit 1
fi

### Install GNU Tools
for tool in "${GNU_TOOLS[@]}"; do
  brew install "${tool}"
done

### Update GNU Tools
for tool in "${GNU_TOOLS_TO_UPDATE[@]}"; do
  brew upgrade "${tool}"
done

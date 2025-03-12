#!/usr/bin/env bash
###
### Script to generate Markdown documentation for a single script.
###
### In contrast to more sophisticated approaches, this script just generates
### the Markdown from lines starting with three hashes (###) and the following
### line.
###
### Usage:
###
### ```bash
### doc-single.sh <script> > <output>
### ```
###

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

function main() {
  local script="${1?Missing script}"
  local line
  # Boolean flag, to signal, if the previous line was an empty documentation
  # line. This is used to prevent multiple empty lines in the output.
  local empty=0

  while IFS= read -r line; do
    if [[ "${line}" =~ ^"###" ]]; then
      local content="${line:3}"
      # If first char is a space, remove it. Do nothing, especially if
      # the line is empty. Do not remove more than once space, as it might
      # be intentional.
      content="${content#"${content%%[![:space:]]*}"}"

      if [[ -n "${content}" ]]; then
        # If the previous line was an empty line, print an empty line to
        # separate the sections.
        if ((empty == 1)); then
          echo
        fi
        empty=0
        echo "${content}"
      else
        # If the line is empty, set the empty flag to true.
        empty=1
      fi
    fi
  done <"${script}"
}

main "${@}"

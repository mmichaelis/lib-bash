#!/usr/bin/env bash
###
### Run all demo scripts.
###

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
declare -r SCRIPT_DIR

# Find all -demo.sh files in the demo directory and run them.
for demo_script in "${SCRIPT_DIR}"/*-demo.sh; do
  if [[ -f "${demo_script}" ]]; then
    echo "Running demo: ${demo_script}"
    "${demo_script}"
    echo
  fi
done

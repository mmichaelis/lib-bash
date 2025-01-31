#!/usr/bin/env bash
###
### Target: pre-commit Hook
###
### Description:
###
###   Enforce that all files with extensions as configured in
###   Git configuration `hooks.enforceExecutable` are executable.
###   If unset, the default extensions are: sh, tcsh, ksh, csh, bash, zsh, fish.
###
###   This hook is intended to especially assist on systems such as Windows,
###   where the executable bit is not preserved when cloning a repository.
###
###   The hook is meant to be invoked by the pre-commit hook.
###
### Usage:
###
###   To install the pre-commit hook, run:
###
###     $ hooks/enforce-executable.sh install
###

# Only declare the DEBUG variable if not already declared.
if [[ -z "${DEBUG-}" ]]; then
  declare -ri DEBUG=0
fi

# ------------------------------------------------------------------------------
# Bash Options
# ------------------------------------------------------------------------------

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes
### Call with `DEBUG=2 <script>.sh <file>` to enable verbose debug output
if ((DEBUG > 1)); then
  set -o xtrace # show expanded commands
else
  set +o xtrace # do not show expanded commands
fi

# ------------------------------------------------------------------------------
# Operation
# ------------------------------------------------------------------------------

function enforce_executable() {
  local -r install="${1:-}"

  function main() {
    local -r extensions=$(git config --get-all hooks.enforceExecutable ||
      echo "sh tcsh ksh csh bash zsh fish")
    local -r staged_files=$(git diff --cached --name-only --diff-filter=ACM)

    if [ -n "$staged_files" ]; then
      # Create a pattern string by joining all elements in the 'extensions' array
      # with a pipe '|' delimiter. The 'IFS' (Internal Field Separator) is
      # temporarily set to '|' to achieve this.
      local -r pattern=$(
        IFS=\|
        echo "${extensions[*]}"
      )
      for file in $staged_files; do
        if [[ "$file" =~ \.($pattern)$ ]]; then
          chmod +x "$file"
          git add --chmod=+x "$file"
        fi
      done
    fi
  }

  function install() {
    local -r git_root=$(git rev-parse --show-toplevel)
    local -r my_file="${git_root}/hooks/enforce-executable.sh"
    local -r dest_file="${git_root}/.git/hooks/pre-commit"
    local -r template_file="${git_root}/hooks/pre-commit.template"

    function ensure_pre_commit_hook() {
      if [ ! -f "${dest_file}" ]; then
        cp "${template_file}" "${dest_file}"
        chmod +x "${dest_file}"
        echo "Pre-commit hook installed successfully."
      fi
    }

    ensure_pre_commit_hook

    if ! grep --quiet "${my_file}" "${dest_file}"; then
      echo "source \"${my_file}\"" >>"${dest_file}"
    fi
  }

  # Install the hook if the first argument is 'install'
  if [ "${install}" = "install" ]; then
    install
  else
    main
  fi
}

enforce_executable "${@}"

#!/usr/bin/env bash
# ==============================================================================
###
### # GNU-Tools Compatibility Layer
###
### This script provides compatibility functions for GNU tools on non-GNU
### systems, such as macOS.
###
### **Usage**:
###
### ```bash
### MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
### SCRIPT_DIR="$(dirname "${MY_PATH}")"
### readonly MY_PATH
### readonly SCRIPT_DIR
### readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
### source "${LIB_BASH_DIR}/lib_gnucompat.sh"
### ```
###
# ==============================================================================

# Guard variable to prevent multiple imports
if [[ -n "${LIB_GNUCOMPAT_SH_INCLUDED:-}" ]]; then
  return
fi
LIB_GNUCOMPAT_SH_INCLUDED=1

LIB_GNUCOMPAT_PATH="$(realpath "${BASH_SOURCE[0]}")"
readonly LIB_GNUCOMPAT_PATH
LIB_GNUCOMPAT_DIR="$(dirname "${LIB_GNUCOMPAT_PATH}")"
readonly LIB_GNUCOMPAT_DIR
# shellcheck source=/dev/null
source "${LIB_GNUCOMPAT_DIR}/lib_init.sh"

# ------------------------------------------------------------------------------
###
### ## Tools Aliases
###
### These functions will return the corresponding GNU-tool on non-GNU systems,
### if available. Such as `gsed` on macOS, which is the GNU version of `sed`.
###
# ------------------------------------------------------------------------------

### * `SED`: GNU `sed` command
if command -v gsed &>/dev/null; then
  readonly SED="gsed"
else
  readonly SED="sed"
fi
export SED

### * `AWK`: GNU `awk` command
if command -v gawk &>/dev/null; then
  readonly AWK="gawk"
else
  readonly AWK="awk"
fi
export AWK

### * `GREP`: GNU `grep` command
if command -v ggrep &>/dev/null; then
  readonly GREP="ggrep"
else
  readonly GREP="grep"
fi
export GREP

### * `FIND`: GNU `find` command
if command -v gfind &>/dev/null; then
  readonly FIND="gfind"
else
  readonly FIND="find"
fi
export FIND

### * `SORT`: GNU `sort` command
if command -v gsort &>/dev/null; then
  readonly SORT="gsort"
else
  readonly SORT="sort"
fi
export SORT

### * `TAR`: GNU `tar` command
if command -v gtar &>/dev/null; then
  readonly TAR="gtar"
else
  readonly TAR="tar"
fi
export TAR

### * `DATE`: GNU `date` command
if command -v gdate &>/dev/null; then
  readonly DATE="gdate"
else
  readonly DATE="date"
fi
export DATE

### * `XARGS`: GNU `xargs` command
if command -v gxargs &>/dev/null; then
  readonly XARGS="gxargs"
else
  readonly XARGS="xargs"
fi
export XARGS

### * `CUT`: GNU `cut` command
if command -v gcut &>/dev/null; then
  readonly CUT="gcut"
else
  readonly CUT="cut"
fi
export CUT

### * `HEAD`: GNU `head` command
if command -v ghead &>/dev/null; then
  readonly HEAD="ghead"
else
  readonly HEAD="head"
fi
export HEAD

### * `TAIL`: GNU `tail` command
if command -v gtail &>/dev/null; then
  readonly TAIL="gtail"
else
  readonly TAIL="tail"
fi
export TAIL

### * `TR`: GNU `tr` command
if command -v gtr &>/dev/null; then
  readonly TR="gtr"
else
  readonly TR="tr"
fi
export TR

### * `UNIQ`: GNU `uniq` command
if command -v guniq &>/dev/null; then
  readonly UNIQ="guniq"
else
  readonly UNIQ="uniq"
fi
export UNIQ

### * `WC`: GNU `wc` command
if command -v gwc &>/dev/null; then
  readonly WC="gwc"
else
  readonly WC="wc"
fi
export WC

### * `DIFF`: GNU `diff` command
if command -v gdiff &>/dev/null; then
  readonly DIFF="gdiff"
else
  readonly DIFF="diff"
fi
export DIFF

# ------------------------------------------------------------------------------
###
### ## Functions
###
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
###
### ### is_gnu
###
### Signal, if the given tool is a GNU tool.
###
### **Usage**:
###
### ```bash
### if ! is_gnu "sed"; then
###   echo "Not a GNU tool."
### fi
### ```
###
# ------------------------------------------------------------------------------
function is_gnu() {
  local cmd="${1:?Error: No command provided to is_gnu function}"

  # Check if the command is available
  if ! command -v "${cmd}" &>/dev/null; then
    return 0
  fi

  ("${cmd}" --version &>/dev/null) || return 1

  local version_output
  version_output="$("${cmd}" --version 2>&1)"
  if [[ "${version_output}" == *"GNU"* ]]; then
    return 0
  else
    return 1
  fi
}

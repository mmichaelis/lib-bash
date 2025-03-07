#!/usr/bin/env bash
###
### GNUTools Compatibility Layer
###
### This script provides compatibility functions for GNU tools on non-GNU
### systems, such as macOS.
###
### Usage:
###
###   SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
###   readonly SCRIPT_DIR
###   source "${SCRIPT_DIR}/lib-bash/lib_gnucompat.sh"
###

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
# Compatibility Functions
#
# These functions will return the corresponding GNU tool on non-GNU systems.
# Such as `gsed` on macOS, which is the GNU version of `sed`.
# ------------------------------------------------------------------------------

# GNU `sed` command
if command -v gsed &>/dev/null; then
  readonly SED="gsed"
else
  readonly SED="sed"
fi
export SED

# GNU `awk` command
if command -v gawk &>/dev/null; then
  readonly AWK="gawk"
else
  readonly AWK="awk"
fi
export AWK

# GNU `grep` command
if command -v ggrep &>/dev/null; then
  readonly GREP="ggrep"
else
  readonly GREP="grep"
fi
export GREP

# GNU `find` command
if command -v gfind &>/dev/null; then
  readonly FIND="gfind"
else
  readonly FIND="find"
fi
export FIND

# GNU `sort` command
if command -v gsort &>/dev/null; then
  readonly SORT="gsort"
else
  readonly SORT="sort"
fi
export SORT

# GNU `tar` command
if command -v gtar &>/dev/null; then
  readonly TAR="gtar"
else
  readonly TAR="tar"
fi
export TAR

# GNU `date` command
if command -v gdate &>/dev/null; then
  readonly DATE="gdate"
else
  readonly DATE="date"
fi
export DATE

# GNU `xargs` command
if command -v gxargs &>/dev/null; then
  readonly XARGS="gxargs"
else
  readonly XARGS="xargs"
fi
export XARGS

# GNU `cut` command
if command -v gcut &>/dev/null; then
  readonly CUT="gcut"
else
  readonly CUT="cut"
fi
export CUT

# GNU `head` command
if command -v ghead &>/dev/null; then
  readonly HEAD="ghead"
else
  readonly HEAD="head"
fi
export HEAD

# GNU `tail` command
if command -v gtail &>/dev/null; then
  readonly TAIL="gtail"
else
  readonly TAIL="tail"
fi
export TAIL

# GNU `tr` command
if command -v gtr &>/dev/null; then
  readonly TR="gtr"
else
  readonly TR="tr"
fi
export TR

# GNU `uniq` command
if command -v guniq &>/dev/null; then
  readonly UNIQ="guniq"
else
  readonly UNIQ="uniq"
fi
export UNIQ

# GNU `wc` command
if command -v gwc &>/dev/null; then
  readonly WC="gwc"
else
  readonly WC="wc"
fi
export WC

# GNU `diff` command
if command -v gdiff &>/dev/null; then
  readonly DIFF="gdiff"
else
  readonly DIFF="diff"
fi
export DIFF

# Signal, if the given tool is a GNU tool
function is_gnu() {
  local cmd="${1:?Error: No command provided to is_gnu function}"

  # Check if the command is a GNU tool by expecting the version output
  # to contain "GNU".
  local version_output
  version_output="$("${cmd}" --version 2>&1)"
  if "${GREP}" -q "GNU" <<<"${version_output}"; then
    return 0
  else
    return 1
  fi
}

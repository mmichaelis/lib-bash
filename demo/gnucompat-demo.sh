#!/usr/bin/env bash
###
### Demo for GNU Tools Compatibility Layer
###

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
declare -r SCRIPT_DIR
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../lib_gnucompat.sh"

# ASSUME_GNU:
#
# Set to "no" to assume non-GNU tools. Defaults to "yes".
# This flag is especially meant to be used in the CI to test with different
# environments set up by the CI. Note, that this does not trigger an enforced
# check of Non-GNU tools, it just triggers a more defensive execution. This is,
# because the CI might have GNU tools installed by default, but the script
# should still be able to run successfully.
readonly ASSUME_GNU="${ASSUME_GNU:-yes}"

# Function to output the path and GNU status of a command
function output_command_info() {
  local cmd_var_name="${1}"
  local cmd="${!cmd_var_name}"
  local cmd_path
  cmd_path=$(command -v "${cmd}")
  local gnu_status
  if is_gnu "${cmd}"; then
    gnu_status="Yes"
  else
    gnu_status="No"
  fi
  echo "${cmd_var_name}: ${cmd_path} (GNU? ${gnu_status})"
}

# Output information for each command
output_command_info "SED"
output_command_info "AWK"
output_command_info "GREP"
output_command_info "FIND"
output_command_info "SORT"
output_command_info "TAR"
output_command_info "DATE"
output_command_info "XARGS"
output_command_info "CUT"
output_command_info "HEAD"
output_command_info "TAIL"
output_command_info "TR"
output_command_info "UNIQ"
output_command_info "WC"
output_command_info "DIFF"

# ------------------------------------------------------------------------------
# Demo for GNU/Non-GNU Compatibility Layer
#
# If ASSUME_GNU is set to "yes", the script will run as if all tools are GNU
# tools. If set to "no", the script will run as if all tools are non-GNU tools.
#
# Thus, if you set to "yes", but the script execution will fail, it may be a
# proof that the demoed library `lib_gnucompat.sh` is not working correctly.
# ------------------------------------------------------------------------------

function demo_sed() {
  echo "SED Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    local -r sed_script='s/World/GNU/g'
    # This command will fail if the GNU version of `sed` is not available.
    echo "${input}" | "${SED}" --regexp-extended "${sed_script}"
    ;;
  *)
    local -r sed_script='s/World/Non-GNU/g'
    echo "${input}" | "${SED}" -r "${sed_script}"
    ;;
  esac
}

function demo_awk() {
  echo "AWK Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # shellcheck disable=SC2016
    local -r awk_script='{ print "Hello, GNU!" }'
    # This command will fail if the GNU version of `sed` is not available.
    echo "${input}" | "${AWK}" --non-decimal-data "${awk_script}"
    ;;
  *)
    # shellcheck disable=SC2016
    local -r awk_script='{ print "Hello, Non-GNU!" }'
    echo "${input}" | "${AWK}" "${awk_script}"
    ;;
  esac
}

function demo_grep() {
  echo "GREP Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    local -r grep_pattern="World"
    # This command will fail if the GNU version of `grep` is not available.
    echo "${input}" | "${GREP}" --only-matching "${grep_pattern}"
    ;;
  *)
    local -r grep_pattern="World"
    echo "${input}" | "${GREP}" "${grep_pattern}"
    ;;
  esac
}

function demo_sort() {
  echo "SORT Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `sort` is not available.
    echo "${input}" | "${SORT}" --ignore-leading-blanks
    ;;
  *)
    echo "${input}" | "${SORT}"
    ;;
  esac
}

function demo_date() {
  echo "DATE Demo:"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `date` is not available.
    "${DATE}" --utc
    ;;
  *)
    "${DATE}"
    ;;
  esac
}

function demo_xargs() {
  echo "XARGS Demo:"
  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `xargs` is not available.
    echo "${input}" | "${XARGS}" --no-run-if-empty echo
    ;;
  *)
    echo "${input}" | "${XARGS}" echo
    ;;
  esac
}

function demo_cut() {
  echo "CUT Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `cut` is not available.
    echo "${input}" | "${CUT}" --characters=3
    ;;
  *)
    echo "${input}" | "${CUT}" -c 3
    ;;
  esac
}

function demo_head() {
  echo "HEAD Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `head` is not available.
    echo "${input}" | "${HEAD}" --lines=1
    ;;
  *)
    echo "${input}" | "${HEAD}" -n 1
    ;;
  esac
}

function demo_tail() {
  echo "TAIL Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `tail` is not available.
    echo "${input}" | "${TAIL}" --lines=1
    ;;
  *)
    echo "${input}" | "${TAIL}" -n 1
    ;;
  esac
}

function demo_tr() {
  echo "TR Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `tr` is not available.
    echo "${input}" | "${TR}" --delete ' '
    ;;
  *)
    echo "${input}" | "${TR}" -d ' '
    ;;
  esac
}

function demo_uniq() {
  echo "UNIQ Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `uniq` is not available.
    echo "${input}" | "${UNIQ}" --count
    ;;
  *)
    echo "${input}" | "${UNIQ}" -c
    ;;
  esac
}

function demo_wc() {
  echo "WC Demo:"

  local -r input="  Hello, World!"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `wc` is not available.
    echo "${input}" | "${WC}" --words
    ;;
  *)
    echo "${input}" | "${WC}" -w
    ;;
  esac
}

function demo_diff() {
  echo "DIFF Demo:"

  local -r input1="Hello, World!"
  local -r input2="Hello, Universe!"
  local -r file1="/tmp/file1.txt"
  local -r file2="/tmp/file2.txt"

  echo "${input1}" >"${file1}"
  echo "${input2}" >"${file2}"

  case "${ASSUME_GNU}" in
  yes)
    # This command will fail if the GNU version of `diff` is not available.
    "${DIFF}" --brief "${file1}" "${file2}"
    ;;
  *)
    "${DIFF}" "${file1}" "${file2}"
    ;;
  esac
}

function demo_all() {
  demo_sed
  demo_awk
  demo_grep
  demo_sort
  demo_date
  demo_xargs
  demo_cut
  demo_head
  demo_tail
  demo_tr
  demo_uniq
  demo_wc
  demo_diff
}

# Run all demos
demo_all

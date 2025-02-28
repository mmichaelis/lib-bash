# lib-bash – Bash Libraries

![Lib-Bash Decorative Image](img/LibBashGitHubSocialPreview.jpg)

A set of libraries to use from within your Bash scripts.

## Table of Contents

* [Library Usage Pattern](#library-usage-pattern)
* [Libraries](#libraries)
  * [lib_console](#lib_init)
  * [lib_init](#lib_init)
  * [lib_scriptinfo](#lib_scriptinfo)
* [Installation](#installation)

## Library Usage Pattern

All libraries are meant to embedded in a similar way. The following applies
best practices according to spellcheck:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_<name>.sh"
```

## Libraries

### lib_console

Utility functions for console output, similar to general logging requirements.
Also, containing a specialized `cat` command supporting colored output.

**Usage Examples**:

```bash
log_debug "Only show if DEBUG=1 (or more)"
log_info "An informational message."
log_warn "A warning notice."
log_error "An error."
log_fatal "A fatal error."

grep "pattern" file.txt | log_debug

ccat <<EOF
${COLOR_RED}This is red text.${COLOR_RESET}
${COLOR_YELLOW}This is yellow text.${COLOR_RESET}
EOF
```

### lib_init

Apply general recommended strictness settings for Bash scripts. Includes support
for `DEBUG` environment variable at two stages: `1` enables debug logging, while
`2` (or above) triggers script debugging.

### lib_scriptinfo

Functions to provide information about your script.

**Usage Examples**:

```bash
SCRIPT_NAME="$(get_script_name)"
readonly SCRIPT_NAME

print_help <<EOF
Usage: ${SCRIPT_NAME} [-h|-?]
EOF
```

## Installation

Find below two possible installation scenarios, assuming, that you want to use
this libraries from your own Git managed repository.

### Git Submodules

```bash
git submodule add https://github.com/mmichaelis/lib-bash.git lib-bash
git submodule update --init --recursive
```

### Git Subtrees

```bash
# Add Subtree
git subtree add --prefix=lib-bash \
  https://github.com/mmichaelis/lib-bash.git main --squash
# Update Subtree
git subtree pull --prefix=lib-bash \
  https://github.com/mmichaelis/lib-bash.git main --squash
```

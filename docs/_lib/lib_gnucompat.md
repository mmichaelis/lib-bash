---
title: "lib_gnucompat – lib-bash"
permalink: /lib/lib_gnucompat/
---

# lib_gnucompat.sh

GNU-Tools Compatibility Layer:

This script provides compatibility functions for GNU tools on non-GNU
systems, such as macOS.

**Usage**:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_gnucompat.sh"
```

## Tools Aliases

These functions will return the corresponding GNU-tool on non-GNU systems,
if available. Such as `gsed` on macOS, which is the GNU version of `sed`.

* `SED`: GNU `sed` command
* `AWK`: GNU `awk` command
* `GREP`: GNU `grep` command
* `FIND`: GNU `find` command
* `SORT`: GNU `sort` command
* `TAR`: GNU `tar` command
* `DATE`: GNU `date` command
* `XARGS`: GNU `xargs` command
* `CUT`: GNU `cut` command
* `HEAD`: GNU `head` command
* `TAIL`: GNU `tail` command
* `TR`: GNU `tr` command
* `UNIQ`: GNU `uniq` command
* `WC`: GNU `wc` command
* `DIFF`: GNU `diff` command

## Functions

### is_gnu

Signal, if the given tool is a GNU tool.

**Usage**:

```bash
if ! is_gnu "sed"; then
echo "Not a GNU tool."
fi
```

---
title: "lib_scriptinfo – lib-bash"
permalink: /lib/lib_scriptinfo/
---

# lib_scriptinfo.sh

Include for script information functions.

**Usage**:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_scriptinfo.sh"
```

## Functions

### get_script_name

Get script name (without path, with extension).

* **Arguments**: _None_
* **Returns**: The script name.

---
title: "lib_init – lib-bash"
permalink: /lib/lib_init/
---

# lib_init.sh

A file for some initial Bash Scripting best practices. It applies the
following settings:

* `errexit`: Abort on nonzero exit status
* `nounset`: Abort on unbound variable
* `pipefail`: Don't hide errors within pipes
* `xtrace`: Show expanded commands if `DEBUG` is set to 2. Set to 1 for
more verbose output.

**Usage**:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_init.sh"
```

## Constants

* `DEBUG`: Provide option to trigger debug output with different verbosity
levels.
Call with `DEBUG=2 <command>.sh <file>` to enable verbose debug output

---
title: "lib_console – lib-bash"
permalink: /lib/lib_console/
---

# lib_console.sh

Include for console support.

**Usage**:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_console.sh"
```

## Color Constants

### Foreground Colors

* `COLOR_RESET`: Reset the color.
* `COLOR_BLACK`: Black color.
* `COLOR_RED`: Red color.
* `COLOR_GREEN`: Green color.
* `COLOR_YELLOW`: Yellow color.
* `COLOR_BLUE`: Blue color.
* `COLOR_MAGENTA`: Magenta color.
* `COLOR_CYAN`: Cyan color.
* `COLOR_WHITE`: White color.
* `COLOR_GRAY`: Gray color.
* `COLOR_LIGHT_RED`: Light red color.
* `COLOR_LIGHT_GREEN`: Light green color.
* `COLOR_LIGHT_YELLOW`: Light yellow color.
* `COLOR_LIGHT_BLUE`: Light blue color.
* `COLOR_LIGHT_MAGENTA`: Light magenta color.
* `COLOR_LIGHT_CYAN`: Light cyan color.
* `COLOR_LIGHT_WHITE`: Light white color.

### Background Colors

* `COLOR_BG_BLACK`: Black background color.
* `COLOR_BG_RED`: Red background color.
* `COLOR_BG_GREEN`: Green background color.
* `COLOR_BG_YELLOW`: Yellow background color.
* `COLOR_BG_BLUE`: Blue background color.
* `COLOR_BG_MAGENTA`: Magenta background color.
* `COLOR_BG_CYAN`: Cyan background color.
* `COLOR_BG_WHITE`: White background color.

## Logging

All logging functions to output information to STDERR. STDERR is preferred,
as it is not affected by the output redirection of the script, thus, the
desired standard output can be redirected to a file or another command.

### log_debug

Output debug message.

The function is used to output debug information. It is only printed
if the `DEBUG` variable is set to a value greater than 0 (zero).

If the standard output supports color, the debug information is printed in
gray color. Otherwise, the debug information is printed without color.

**Usage**:

```bash
log_debug "Only show if DEBUG=1 (or more)"
grep "pattern" file.txt | log_debug
```

### log_info

Output information message.

The function is used to output information messages. No extra color is
used for the information message.

**Usage**:

```bash
log_info "An informational message."
grep "pattern" file.txt | log_info
```

### log_warn

Output warning message.

The function is used to output warning messages. The warning message
is printed in yellow color.

**Usage**:

```bash
log_warn "A warning notice."
grep "pattern" file.txt | log_warn
```

### log_error

Output error message.

The function is used to output error messages. The error message is
printed in red color.

**Usage**:

```bash
log_error "An error."
grep "pattern" file.txt | log_error
```

### log_fatal

Output a fatal error message.

The function is used to output error messages. The error message is
printed with dark red background and bright yellow color.

**Usage**:

```bash
log_fatal "A fatal error."
grep "pattern" file.txt | log_fatal
```

### ccat

Alternative to `cat` that also processes colored input.

**Usage**:

```bash
ccat <<EOF
${COLOR_RED}This is red text.${COLOR_RESET}
${COLOR_YELLOW}This is yellow text.${COLOR_RESET}
EOF
```

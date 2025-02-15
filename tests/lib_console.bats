#!/usr/bin/env bats

# Load the script to test
setup() {
  source "${BATS_TEST_DIRNAME}/../lib_console.sh"
}

@test "debug outputs no message by default" {
  run debug "This is a debug message"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test "debug function outputs debug message when DEBUG is set" {
  DEBUG=1
  run debug "This is a debug message"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "[DEBUG] This is a debug message" ]
}

@test "info function outputs info message" {
  run info "This is an info message"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "[INFO] This is an info message" ]
}

@test "warn function outputs warning message" {
  run warn "This is a warning message"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "[WARNING] This is a warning message" ]
}

@test "error function outputs error message" {
  run error "This is an error message"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "[ERROR] This is an error message" ]
}

@test "fatal function outputs fatal message" {
  run fatal "This is a fatal message"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "[FATAL] This is a fatal message" ]
}

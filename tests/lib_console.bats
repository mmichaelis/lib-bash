#!/usr/bin/env bats

# Load the script to test
setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  source "${BATS_TEST_DIRNAME}/../lib_console.sh"
}

@test "debug outputs no message by default" {
  run debug "This is a debug message" 2>&1
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test "debug function outputs debug message when DEBUG is set" {
  DEBUG=1
  run debug "This is a debug message" 2>&1
  assert_success
  assert_output "[DEBUG] This is a debug message"
}

@test "info function outputs info message" {
  run info "This is an info message" 2>&1
  assert_success
  assert_output "[INFO] This is an info message"
}

@test "warn function outputs warning message" {
  run warn "This is a warning message" 2>&1
  assert_success
  assert_output "[WARNING] This is a warning message"
}

@test "error function outputs error message" {
  run error "This is an error message" 2>&1
  assert_success
  assert_output "[ERROR] This is an error message"
}

@test "fatal function outputs fatal message" {
  run fatal "This is a fatal message" 2>&1
  assert_success
  assert_output "[FATAL] This is a fatal message"
}

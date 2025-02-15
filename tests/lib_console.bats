#!/usr/bin/env bats

# Load the script to test
setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  source "${BATS_TEST_DIRNAME}/../lib_console.sh"
}

@test "log_debug outputs no message by default" {
  run log_debug "This is a debug message"
  assert_success
  [ "${#lines[@]}" -eq 0 ]
}

@test "log_debug function outputs debug message when DEBUG is set" {
  DEBUG=1
  run log_debug "This is a debug message"
  assert_success
  assert_output "[DEBUG] This is a debug message"
}

@test "log_info function outputs info message (function usage)" {
  run log_info "This is an info message"
  assert_success
  assert_output "[INFO] This is an info message"
}

@test "log_info function outputs info message (piped usage)" {
  function function_under_test() {
    echo "This is an info message" | log_info
  }
  run function_under_test
  assert_success
  assert_output "[INFO] This is an info message"
}

@test "log_info function outputs info message (HERE document, piped usage)" {
  function function_under_test() {
    cat <<EOF | log_info
This is an info message
EOF
  }
  run function_under_test
  assert_success
  assert_output "[INFO] This is an info message"
}

@test "log_info function outputs info message (HERE document)" {
  function function_under_test() {
    log_info <<EOF
This is an info message
EOF
  }
  run function_under_test
  assert_success
  assert_output "[INFO] This is an info message"
}

@test "log_warn function outputs warning message" {
  run log_warn "This is a warning message"
  assert_success
  assert_output "[WARNING] This is a warning message"
}

@test "log_error function outputs error message" {
  run log_error "This is an error message"
  assert_success
  assert_output "[ERROR] This is an error message"
}

@test "log_fatal function outputs fatal message" {
  run log_fatal "This is a fatal message"
  assert_success
  assert_output "[FATAL] This is a fatal message"
}

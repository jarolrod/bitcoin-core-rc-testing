#!/bin/bash

source_tests() {
  local x=1
  local file_base_name=''
  local function_name=''
  TEST_FILE_NAME=()
  TEST_FUNCTION=()
  echo " "
  echo "${BOLD}Sourcing test files:${RESET}"
  cd ${TEST_DIR}
  NUM_TEST="$(ls | wc -l | xargs)" # gets number of tests

  for test in ${TEST_DIR}/*;
  do
    file_base_name=$(basename -- $test)
    echo "[${x}/${NUM_TEST}]: ${file_base_name}"
    TEST_FILE_NAME+=($file_base_name)
    function_name=${file_base_name%.*}
    TEST_FUNCTION+=($function_name)
    source $test;

    # Get the function name inside the test
    # run this function name in run tests
    x=$((x + 1))
  done
}

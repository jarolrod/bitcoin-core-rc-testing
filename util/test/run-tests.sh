#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Source all test scripts

run_tests() {
  TEST_INDEX=1
  local file_base_name=''
  local function_name=''
  local dir_num_tests=0

  CURRENT_TEST_FILE=''
  CURRENT_TEST_NAME=''
  echo " "
  echo "${BOLD}Running Tests:${RESET}"
  cd ${TEST_DIR}
  NUM_TEST=0

  # log test start in data.json
  echo "
  \"test_data\": { " >> ${DATA_FILE}

  local test_dir_num=$(ls ${TEST_DIR} | wc -l | xargs)
  local test_dir_index=1

  for dir in ${TEST_DIR}/*;
  do
    TEST_TYPE="$(basename -- ${dir} | tr a-z A-Z)"
    echo "${BOLD}${TEST_TYPE} Tests${RESET}"
    # Log test type
    echo "    \"${TEST_TYPE}\": {" >> ${DATA_FILE}

    dir_num_tests=$(ls ${dir} | wc -l | xargs)   # gets number of tests
    [ $dir_num_tests -gt 1 ] \
      && {
        NUM_TEST=$(( $NUM_TEST + $dir_num_tests ))
        # Test is a shell script
        for test in ${dir}/*.sh;
        do
          file_base_name=$(basename -- $test)
          function_name=${file_base_name%.*}
          source $test;
          CURRENT_TEST_FILE="${file_base_name}"
          CURRENT_TEST_NAME="${function_name}"
          # Test has been sourced -> run
          ${function_name}
          ((TEST_INDEX++))
        done
      } \
      || echo "${WARNING} No tests found in this directory"

    # Add ending bracket -> with or without comma
    [ $test_dir_index -eq $test_dir_num ] \
      && echo "    }" >> ${DATA_FILE} \
      || echo "    }," >> ${DATA_FILE}

    # Move to next test
    ((test_dir_index++))
  done

  # Signal that all tests are complete
  TEST_COMPLETE=1

  # close test_data json object
  echo "  }" >> ${DATA_FILE}

  # close data.json
  echo "}" >> ${DATA_FILE}
}

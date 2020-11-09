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

  TEST_FILE_NAME=()
  TEST_FUNCTION=()
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
    # of dirs

    dir_num_tests=$(ls ${dir} | wc -l | xargs)   # gets number of tests
    if [ $dir_num_tests -gt 1 ]; then
      NUM_TEST=$(( $NUM_TEST + $dir_num_tests ))
      for test in ${dir}/*.sh;    # Test is a shell script
      do
        file_base_name=$(basename -- $test)
        #TEST_FILE_NAME+=($file_base_name)
        function_name=${file_base_name%.*}
        #TEST_FUNCTION+=($function_name)
        source $test;
        CURRENT_TEST_FILE="${file_base_name}"
        CURRENT_TEST_NAME="${function_name}"
        # Test has been sourced -> run
        ${function_name}

        ((TEST_INDEX++))
      done
    else
      echo "${WARNING} No tests found in this directory"
    fi

    if [ $test_dir_index -eq $test_dir_num ]; then
      # Close json object for this type of test without comma
      echo "    }" >> ${DATA_FILE}
    else
      echo "    }," >> ${DATA_FILE}
    fi
    ((test_dir_index++))
  done

  # close test_data json object
  echo "  }" >> ${DATA_FILE}

  # close data.json
  echo "}" >> ${DATA_FILE}
}

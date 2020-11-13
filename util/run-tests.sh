#!/bin/bash

run_tests() {
  local i=1
  local d=0
  local func_name=''
  echo "${BOLD}Running tests:${RESET}"

  cd $BTC_SRC

  while [ $d -lt $NUM_TEST ]
  do
    func_name="${TEST_FUNCTION[$d]}"
    $func_name
    echo "${SUCCESS} ${func_name} [$i/${NUM_TEST}]"

    ((d++))
    ((i++))
  done
}

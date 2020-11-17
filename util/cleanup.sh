#!/bin/bash

cleanup () {
  echo "${BOLD}Cleaning Up:${RESET}"
  local index=0
  while [ $index -lt 3 ]
  do
    # stop running nodes
    run_rpc $index stop
    ((index++))
  done

  
  rm "${REGTEST_DIR}/SHA256SUMS.asc"
  # delete Bitcoin directory
  rm -rf $BITCOIN_DIR
}

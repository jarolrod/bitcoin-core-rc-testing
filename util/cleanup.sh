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

  # delete everything in the Bitcoin directory
  cd ${BITCOIN_DIR}
  rm -rf *     # delete hidden files

  if [ $COMPILE = 1 ]; then
    rm -rf .*
  fi
}

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

  echo "${BOLD}There is a captured file of your test data at: "
  echo "${GREEN}${DATA_FILE}${RESET}${BOLD}"
  echo "This file contains: "
  echo "  1. System information"
  echo "  2. Script configuration options"
  echo "  3. Test result data"

  # If Telemetry is enabled
  if [ $TELEMETRY = 1 ]; then
    # ask permission before sending file
    echo "You have chosen to contribute your data anonymously"
    ask_permission "Please confirm you still wish to send your data: <y/n> "

    if [ $CHOICE = 1 ]; then
      # send data
      echo "thank you!"
      exit
    fi
  fi

  # user does not want to send data
  # prompt that the file exists
  echo -n "If you would still like to contribute your test data, "
  echo "please cut and paste your data here: [Link TBD]"

}

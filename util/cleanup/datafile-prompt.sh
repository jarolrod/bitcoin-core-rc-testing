#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Informs about the contents of the data file

datafile_prompt() {
  # Seperate new section
  seperator

  echo "${BOLD}There is a captured file of your test data at: "
  echo "${GREEN}${DATA_FILE}${RESET}${BOLD}"
  echo "This file contains: "

  [ -z ${SYS_INFO_WRITE+x} ] || echo "  1. System information"
  [ -z ${CONFIG_INFO_WRITE+x} ] || echo "  2. Script configuration options"
  [ -z ${TEST_COMPLETE+x} ] || echo "  3. Test result data"

  # If Telemetry is enabled
  [ $TELEMETRY = 1 ] && {
    # ask permission before sending file
    echo "You have chosen to contribute your data anonymously"
    ask_permission "Please confirm you still wish to send your data: <y/n> "
    [ $CHOICE = 1 ] && { echo "thank you!" ; exit ; }
  }

  # user does not want to send data
  # prompt that the file exists
  echo -n "If you would still like to contribute your test data, "
  echo "please cut and paste your data here: [Link TBD]"
  exit
}

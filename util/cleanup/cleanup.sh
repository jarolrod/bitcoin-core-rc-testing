#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check that system has proper requirements for compiling Bitcoin

cleanup () {
  echo "${BOLD}Cleaning Up:${RESET}"
  # Stop running bitcoin nodes
  stop_nodes

  # Remove old cryptographic checksum file
  remove_shasums

  # Delete Bitcoin directory
  remove_bitcoindir

  # Display data file prompt
  datafile_prompt
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
}

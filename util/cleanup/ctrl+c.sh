#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Traps a ctrl+c signal and runs cleanup

ctrl+c() {
  # Confirm user wants to quit
  echo "${BOLD}${YELLOW}Script will now stop.${RESET}"
  SCRIPT_INTERRUPT=1      # Signal that script was interrupted
  sleep 1                 # sleep for visual clarity
  cleanup                 # run cleanup
}

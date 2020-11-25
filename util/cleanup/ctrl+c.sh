#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Traps a ctrl+c signal and runs cleanup

ctrl+c() {
  # Confirm user wants to quit
  echo "${BOLD}${YELLOW}Script will now stop.${RESET}"
  sleep 1
  exit

  # Has system check happened?

  # Has configuration complete?

  # Did Downloading Bitcoin source/code release finish?

  # Did unpacking finish?

  # Did checking sigs finish?

  # If compile -> Did compiling finish

  # Did tests finsh?

}

#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Informs about the contents of the data file

datafile_prompt() {
  echo "${BOLD}There is a captured file of your test data at: "
  echo "${GREEN}${DATA_FILE}${RESET}${BOLD}"
  echo "This file contains: "

  [ $SYS_INFO_WRITE = 1 ] && echo "  1. System information"
  [ $CONFIG_INFO_WRITE = 1 ] && echo "  2. Script configuration options"
  [ $TEST_COMPLETE = 1 ] && echo "  3. Test result data"
  
}

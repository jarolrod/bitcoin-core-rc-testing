#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Runs upon a successful test

test_success() {

  echo "${SUCCESS} ${CURRENT_TEST_FILE} [${TEST_INDEX}/${NUM_TEST}]"

  write_test_info $CURRENT_TEST_NAME 1

}

#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# log test data to data.json

write_test_info() {
  # write test status
  write_test_status ${1} ${2}

  # write test log
  write_test_log


  # close test json object
  [ $TEST_INDEX -eq $NUM_TEST ] \
    && {
      echo "
        }" >> ${DATA_FILE}
    } \
    || {
      echo "
        }," >> ${DATA_FILE}
    }
}

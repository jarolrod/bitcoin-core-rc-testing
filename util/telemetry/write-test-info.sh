#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# log test data to data.json

write_test_info() {

  if [ $TEST_INDEX -eq $NUM_TEST ]; then
    echo "
      \"$1\": {
        \"success\": 1
      }" >> ${REGTEST_DIR}/data.json
  else
    echo "
      \"$1\": {
        \"success\": 1
      }," >> ${REGTEST_DIR}/data.json
  fi
}

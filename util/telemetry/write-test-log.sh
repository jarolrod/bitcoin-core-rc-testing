#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# write test log to data.json

write_test_log() {

  for key in "${!CURRENT_TEST_LOG[@]}"; do
    echo "
      \"$key\": ${CURRENT_TEST_LOG[$key]}" >> ${DATA_FILE}
  done
}

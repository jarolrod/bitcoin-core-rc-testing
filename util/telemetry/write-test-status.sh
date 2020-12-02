#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# log test status

write_test_status() {
  echo "
    \"$1\": {
      \"success\": ${2}," >> ${DATA_FILE}

}

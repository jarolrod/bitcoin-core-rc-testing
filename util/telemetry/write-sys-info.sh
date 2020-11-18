#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# write system information to test-results.json

write_sys_info() {
  # 1. system_type
  # 2. operating_system
  # 3. processor
  # 4. kernel
  echo "" > ${REGTEST_DIR}/data.json
  echo "{
  \"system\": {
    \"system_type\": \"${SYS_TYPE}\",
    \"operating_system\": \"${OS}\",
    \"kernel\": \"${KERNEL}\",
    \"processor\": \"${PROCESSOR}\"
  }," >> ${REGTEST_DIR}/data.json

}

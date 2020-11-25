#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# write system information to test-results.json

write_config_info() {
  # 1. bitcoin_ver
  # 2. download: <type>
  # 3. download_link
  # 4. check_sig: did signature verification pass
  # 5. telemetry: opt in to send data?
  # 6. compile

  echo "
  \"configuration\": {
    \"bitcoin_ver\": \"${BITCOIN_VER}\",
    \"download_type\": \"${TYPE}\",
    \"download_link\": \"${DOWNLOAD_LINK}\",
    \"telemetry_optin\": ${TELEMETRY},
    \"compile\": ${COMPILE}
  }," >> ${DATA_FILE}

  CONFIG_INFO_WRITE=1
}

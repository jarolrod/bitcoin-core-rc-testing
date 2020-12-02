#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check for redundant bitcoin archive file in bitcoindir

persistent_zip() {
  echo "${RESET}${BOLD}[${1}/${2}]: Check for Persistent Zip"
  local bitcoin_zip=$(find ${REGTEST_DIR} -type f -name "*.gz")
  # Found a bitcoin zip
  [ -z "${bitcoin_zip}"] \
    && echo "${SUCCESS} No persistent Bitcoin archive file found" \
    || {
      local basename_zip=$(basename -- ${bitcoin_zip})
      echo $basename_zip
      rm ${REGTEST_DIR}/${bitcoin_zip}
      echo "${SUCCESS} Removed persistent Bitcoin archive file"
    }

}

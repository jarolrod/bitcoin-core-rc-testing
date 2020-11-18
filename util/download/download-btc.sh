#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Download a copy of Bitcoin

function download_btc {
  # Download will now begin
  echo "${BOLD}Downloading ${BITCOIN_VER} ${TYPE}${BLUE}"

  # Download Bitcoin
  cd ${REGTEST_DIR}
  curl --progress-bar $DOWNLOAD_LINK -O
}

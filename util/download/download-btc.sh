#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Download a copy of Bitcoin

download_btc() {
  # Seperate new section
  seperator

  # Download will now begin
  echo "${BOLD}Downloading ${BITCOIN_VER} ${TYPE}${BLUE}"

  # Download Bitcoin
  cd ${REGTEST_DIR}
  curl --progress-bar -L ${DOWNLOAD_LINK} -O
  ZIP_DOWNLOADED=1
}

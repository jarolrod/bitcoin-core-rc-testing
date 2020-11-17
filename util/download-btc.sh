#!/bin/bash

function download_btc {
  # Download will now begin
  echo "${BOLD}Downloading ${BITCOIN_VER} ${TYPE}${BLUE}"

  # Download Bitcoin
  cd ${REGTEST_DIR}
  curl --progress-bar $DOWNLOAD_LINK -O
}

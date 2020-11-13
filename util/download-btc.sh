#!/bin/bash

function download_btc {
  # Download will now begin
  echo "${BOLD}Downloading ${BITCOIN_VER} ${TYPE}${BLUE}"

  # Download Bitcoin
  curl --progress-bar $DOWNLOAD_LINK -o "${BITCOIN_DIR}/$BITCOIN_ZIP"
}

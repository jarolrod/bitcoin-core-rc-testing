#!/bin/bash

# Helper Function to unpack Bitcoin
unpack_btc() {
  # Test for Bitcoin Archive File in CWD
  echo "${RESET}${BOLD}Unpacking ${BITCOIN_VER} ${TYPE}${RESET}"
  if test -f "${BITCOIN_DIR}/$BITCOIN_ZIP"; then
    echo "${SUCCESS} Found Bitcoin Archive File"
      # Begin to unpack release
      tar -xzf "${BITCOIN_DIR}/$BITCOIN_ZIP" -C ${BITCOIN_DIR} --strip-components 1
      # Cleanup tarball
      rm ${BITCOIN_DIR}/$BITCOIN_ZIP
    echo "${SUCCESS} Unpacked Bitcoin Archive File"
  # No Bitcoin Archive File found in CWD -> should not happen
  else
    echo "${FAILURE} Could not find Bitcoin Archive File"
    exit
  fi
}

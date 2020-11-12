#!/bin/bash

# Helper Function to unpack Bitcoin
unpack_release() {
  # Test for Bitcoin Archive File in CWD
  echo "${RESET}${BOLD}Unpacking ${BITCOIN_VER} Release${RESET}"
  if test -f "$BITCOIN_ZIP"; then
    echo "${SUCCESS} Found Bitcoin Archive File"
      # Begin to unpack release
      tar -xzf $BITCOIN_ZIP -C ./bitcoin --strip-components 1
      # Cleanup tarball
      rm $BITCOIN_ZIP
    echo "${SUCCESS} Unpacked Bitcoin Archive File"
  # No Bitcoin Archive File found in CWD -> should not happen
  else
    echo "${FAILURE} Could not find Bitcoin Archive File"
    exit
  fi
}

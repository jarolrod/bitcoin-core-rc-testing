#!/bin/bash

# Helper Function to unpack Bitcoin
unpack_release() {
  # Test for Bitcoin Archive File in CWD
  if test -f "$BITCOIN_ZIP"; then
    echo "Success: Found Bitcoin Archive File"
      # Begin to unpack release
      tar -xzf $BITCOIN_ZIP -C ./bitcoin --strip-components 1
      # Cleanup tarball
      rm $BITCOIN_ZIP
    echo "Success: Unpacked Bitcoin Archive File"
  # No Bitcoin Archive File found in CWD -> should not happen
  else
    echo "Fatal Error: Could not find Bitcoin Archive File"
    exit
  fi
}

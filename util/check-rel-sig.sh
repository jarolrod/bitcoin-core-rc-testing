#!/usr/bin/env bash

check_rel_sig() {
  # Download SHA256SUMS.asc
  echo "${RESET}${BOLD}Downloading Cryptographic Checksums${BLUE}"

  # we should already be in the REGTEST_DIR
  curl --progress-bar $RELEASE_SIG -O

  # Verify
  echo "${RESET}${BOLD}Verifying ${BITCOIN_VER} ${TYPE} Signatures"

  # Mac
  if [ $SYS_TYPE = "MAC" ]; then
    # Search for a line with OK
    local check_ok=$(shasum -a 256 --check SHA256SUMS.asc 2>&1 | grep OK)

    # if check_ok is not empty, we found an 'OK' line
    if [ ! -z "${check_ok}" ]; then
      # check that it corresponds to appropriate release file
      echo "${SUCCESS} ${check_ok}"
    else
      echo "${FAILURE} Could not verify signature"
      exit
    fi

  # Linux
  else
    echo "hello I need to test this on my linux partition"
  fi
}

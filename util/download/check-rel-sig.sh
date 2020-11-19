#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Checks for signature integrity of Bitcoin files

check_rel_sig() {
  # Download SHA256SUMS.asc
  echo "${RESET}${BOLD}Downloading Cryptographic Checksums${BLUE}"

  # we should already be in the REGTEST_DIR
  curl --progress-bar $RELEASE_SIG -O

  # Verify
  echo "${RESET}${BOLD}Verifying ${BITCOIN_VER} ${TYPE} Signatures"

  local check_ok=''
  # Mac
  if [ $SYS_TYPE = "MAC" ]; then
    # Search for a line with OK
    check_ok=$(shasum -a 256 --check SHA256SUMS.asc 2>&1 | grep OK)
  # Linux
  else
    check_ok=$(sha256sum --ignore-missing --check SHA256SUMS.asc 2>&1 | grep OK)
  fi

  # if check_ok is not empty, we found an 'OK' line
  if [ ! -z "${check_ok}" ]; then
    # check that it corresponds to appropriate release file
    echo "${SUCCESS} ${check_ok}"
  else
    echo "${FAILURE} Could not verify signature"
    exit
  fi
}

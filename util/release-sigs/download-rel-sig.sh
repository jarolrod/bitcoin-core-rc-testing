#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Download Release Signature SHA256SUM.asc File

download_rel_sig() {
  # Download SHA256SUMS.asc
  echo "${RESET}${BOLD}Downloading Cryptographic Checksums${BLUE}"

  # we should already be in the REGTEST_DIR
  curl --progress-bar $RELEASE_SIG -O
}

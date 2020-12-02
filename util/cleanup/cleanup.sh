#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Cleanup files

cleanup () {
  # Seperate new section
  seperator

  echo -n "${BOLD}Cleaning Up:${RESET}"
  [ -z ${SCRIPT_INTERRUPT+x} ] && { echo "" ; } \
  || { echo "${RED} Script terminated" ; }

  # Stop running bitcoin nodes
  stop_nodes 1 4

  # Check for existing zip file
  [ -z ${ZIP_DOWNLOADED+x} ] || persistent_zip 2 4

  # Delete bitcoin directory
  [ -z ${CREATED_BITCOIN_DIR+x} ] || remove_bitcoindir 3 4

  # Remove old cryptographic checksum file
  [ -z ${INTEGRITY_CHECK+x} ] || remove_shasums 4 4

  # Display data file prompt
  datafile_prompt
}

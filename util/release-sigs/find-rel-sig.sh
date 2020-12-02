#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Find Release Signature File

find_rel_sig() {
  # find sig file
  local find_sig_file=$(find ${REGTEST_DIR} -type f -name "*.asc")

  [ -n "$find_sig_file" ] \
    && {
      echo "${SUCCESS} Found SHA256SUM.asc file"
      FOUND_SIG=1
    } \
    || {
      echo "${FAILURE} Could not find SHA256SUM.asc file"
    }
}

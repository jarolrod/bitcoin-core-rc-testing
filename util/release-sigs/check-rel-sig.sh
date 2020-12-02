#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Checks for signature integrity of Bitcoin files

check_rel_sig() {
  # Download Signatures
  download_rel_sig

  # Seperate new section
  seperator

  # Verify
  echo "${RESET}${BOLD}Verifying ${BITCOIN_VER} ${TYPE} Signatures"

  # Find SHASUM File
  find_rel_sig

  [ -z ${FOUND_SIG+x} ] \
    && {
      echo "${WARNING} Could not verify signature"
    } \
    || {
      local check_ok=''
      [ $SYS_TYPE = "MAC" ] && {
        check_ok=$(shasum -a 256 --check SHA256SUMS.asc 2>&1 | grep OK) ; }
      [ $SYS_TYPE = "LINUX" ] && {
        check_ok=$(sha256sum --ignore-missing --check SHA256SUMS.asc 2>&1 | grep OK) ; }

      # if check_ok is not empty, we found an 'OK' line
      [ -n "${check_ok}" ] \
        && echo "${SUCCESS} ${check_ok}" \
        || echo "${WARNING} Could not verify signature"
    }


  # Integrity check occurred
  INTEGRITY_CHECK=1

}

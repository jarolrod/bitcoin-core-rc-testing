#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Helper Function to unpack Bitcoin

unpack_btc() {
  # Compile if user downloaded source
  echo "${RESET}${BOLD}Unpacking ${BITCOIN_VER} ${TYPE}${RESET}"
  # Find a bitcoin archive file
  local bitcoin_zip=$(basename -- $(find ${REGTEST_DIR} -type f -name "*.gz"))
  # Found if local_zip is not empty
  [ -n "${bitcoin_zip}" ] \
    && {
      echo "${SUCCESS} Found Bitcoin ${TYPE} Archive File"
      # unpack and remove archive file
      tar -xf "${bitcoin_zip}" && rm ${bitcoin_zip}

      # Find the unarchived Bitcoin Directory
      BITCOIN_DIR=$(find ${REGTEST_DIR} -maxdepth 1 -type d -name "bitcoin*")

      # Found if not empty
      [ -n "$BITCOIN_DIR" ] \
        && echo "${SUCCESS} Unpacked Bitcoin ${TYPE} Archive File" \
        || { echo "${FAILURE} Could not unpack Bitcoin ${TYPE} Archive File" ; exit ; }
    } \
    || { echo "${FAILURE} Could not find Bitcoin Archive File" ; exit ; }

  [ $COMPILE = 1 ] \
    && { compile_btc ; BTC_SRC="${BITCOIN_DIR}/src" ; } \
    || BTC_SRC="${BITCOIN_DIR}/bin"
}

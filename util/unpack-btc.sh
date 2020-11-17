#!/bin/bash

# Helper Function to unpack Bitcoin
unpack_btc() {

  # Compile if user downloaded source
  echo "${RESET}${BOLD}Unpacking ${BITCOIN_VER} ${TYPE}${RESET}"

  # Find a bitcoin archive file
  local bitcoin_zip=$(basename -- $(find ${REGTEST_DIR} -type f -name "*.gz"))

  # Found if local_zip is not empty
  if [ ! -z "${bitcoin_zip}" ]; then
    echo "${SUCCESS} Found Bitcoin ${TYPE} Archive File"
    # unpack and remove archive file
    tar -xzf "${bitcoin_zip}"
    rm ${bitcoin_zip}

    # Find the unarchived Bitcoin Directory
    BITCOIN_DIR=$(find ${REGTEST_DIR} -maxdepth 1 -type d -name "bitcoin*")

    # Found if not empty
    if [ ! -z "$BITCOIN_DIR" ]; then
      echo "${SUCCESS} Unpacked Bitcoin ${TYPE} Archive File"

    else
      echo "${FAILURE} Could not unpack Bitcoin ${TYPE} Archive File"
    fi

    # No Bitcoin Archive File found in CWD -> should not happen
    else
      echo "${FAILURE} Could not find Bitcoin Archive File"
      exit
  fi

  # Extra steps if compile
  if [ $COMPILE = 1 ]; then
    # compile
    compile_btc

    # update btc_src
    BTC_SRC="${BITCOIN_DIR}/src"
  else
    BTC_SRC="${BITCOIN_DIR}/bin"
  fi
}

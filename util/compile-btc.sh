#!/bin/bash

function compile_btc {
  cd ${BITCOIN_DIR}
  echo "${BOLD}Compiling ${BITCOIN_VER} ${TYPE}${RESET}"

  ./autogen.sh
  ./configure
  make -j5
}

#!/bin/bash

function compile_btc {
  cd ${BITCOIN_DIR}
  echo "${BOLD}Compiling ${BITCOIN_VER} ${TYPE}${RESET}"

  ./autogen.sh
  ./configure
  # Mac
  if [ $SYS_TYPE = "MAC" ]; then
    make -j"$(($(sysctl -n hw.logicalcpu)+1))"
    # Linux
  else
    make -j"$(($(nproc)+1))"
  fi
}

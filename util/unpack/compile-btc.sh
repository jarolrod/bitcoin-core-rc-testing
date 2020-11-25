#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# compile bitcoin source code

compile_btc() {
  cd ${BITCOIN_DIR}
  echo "${BOLD}Compiling ${BITCOIN_VER} ${TYPE}${RESET}"

  ./autogen.sh > /dev/null 2>&1 && echo "${SUCCESS} ./autogen complete"
  ./configure --without-gui > /dev/null 2>&1 && echo "${SUCCESS} ./configure complete"

  [ $SYS_TYPE = "MAC" ] && make -j"$(($(sysctl -n hw.logicalcpu)+1))" > /dev/null 2>&1
  [ $SYS_TYPE = "LINUX" ] && make -j"$(($(nproc)+1))" > /dev/null 2>&1

  echo "${SUCCESS} Compiled ${BITCOIN_VER}"
}

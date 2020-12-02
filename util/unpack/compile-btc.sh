#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# compile bitcoin source code

compile_btc() {
  # Seperate new section
  seperator

  cd ${BITCOIN_DIR}
  echo "${BOLD}Compiling ${BITCOIN_VER} ${TYPE}${RESET}"

  # run ./autogen
  echo "${RUNNING} ./autogen.sh"
  ./autogen.sh > /dev/null 2>&1 && \
  echo -e "\e[1A\e[K${SUCCESS} ./autogen complete"

  # run ./configure
  echo -e "${RUNNING} ./configure"
  ./configure --without-gui > /dev/null 2>&1 && \
  echo -e "\e[1A\e[K${SUCCESS} ./configure complete"

  # run make -j{n}
  echo "${RUNNING} Compiling ${BITCOIN_VER}"
  [ $SYS_TYPE = "MAC" ] && make -j"$(($(sysctl -n hw.logicalcpu)+1))" > /dev/null 2>&1
  [ $SYS_TYPE = "LINUX" ] && make -j"$(($(nproc)+1))" > /dev/null 2>&1
  echo -e "\e[1A\e[K${SUCCESS} Compiled ${BITCOIN_VER}"
}

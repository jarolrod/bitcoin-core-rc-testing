#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Gives nodes time to warm-up before running tests

node_warmup () {
  c=1 # seconds to wait
  echo "${BOLD}Node is warming up"
  REWRITE=". "
  while [ $c -le 5 ]; do
      c=$((c+1))
      echo -ne "${REWRITE}"
      sleep 1
      REWRITE+=". "
  done
}

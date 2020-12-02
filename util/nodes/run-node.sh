#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# run a node

run_node() {
  ${BTC_SRC}/./bitcoind -datadir=${1} -daemon 

  # TODO Check that node successfully runs

}

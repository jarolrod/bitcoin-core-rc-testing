#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Command a node to run a provided rpc command

# $1. datadir, $2. rpc string
run_rpc() {
  ${BTC_SRC}/./bitcoin-cli -datadir=${1} ${2}
}

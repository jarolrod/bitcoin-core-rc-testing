#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Command a node to run a provided rpc command

# $1. node index, $2. rpc string
run_rpc() {
  # Compose complete rpc command string
  rpc_string="${BITCOINCLI[$1]} $2"
  # run rpc command, fail if error
  ${BTC_SRC}/${rpc_string}
}

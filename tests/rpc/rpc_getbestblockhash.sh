#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# test rpc command: getblockhash

rpc_getbestblockhash() {

  # initial hash
  local i_hash_0=$(run_rpc 0 getbestblockhash)

  # check bestblockhash has been updated
  if [ ! $i_hash_0 = 0 ]; then
    test_success
  else
    test_failure
  fi
}

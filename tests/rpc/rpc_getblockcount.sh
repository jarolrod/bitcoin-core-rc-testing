#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# test rpc command: getblockcount

rpc_getblockcount() {

  # initial block count
  local i_count=$(run_rpc 1 getblockcount)

  if [ $i_count -eq 0 ]; then
    test_success
  else
    test_failure
  fi
}

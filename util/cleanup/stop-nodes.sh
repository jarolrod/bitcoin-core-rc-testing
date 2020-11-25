#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# send stop rpc command to running bitcoin nodes

stop_nodes() {
  local index=0
  while [ $index -lt 3 ]
  do
    # stop running nodes
    run_rpc ${index} "stop" > /dev/null 2>&1
    ((index++))
  done

  echo "${SUCCESS} Shut down all running Bitcoind nodes."
}

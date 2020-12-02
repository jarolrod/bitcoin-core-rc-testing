#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check that a node has a certain number of peers
# ${1}: Data directory, ${2}: number of peers

check_peers() {
  local peers=0
  local check_connections=0
  while [ $peers -lt $2 ]
  do
    check_connections=$(grep -c 'New outbound peer connected' ${1}/debug.log)
    # check connections must be greater than peers
    [ $check_connections -gt $peers ] \
      && {
        echo "[${check_connections}/${2}] Peers Connected"
        ((peers++))
      }
  done
}

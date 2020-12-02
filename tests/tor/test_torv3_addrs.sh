#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Test TorV3 addresses on 0.21 rc candidate

test_torv3_addrs() {
  # Create data directory
  TorNodeDir="${BITCOIN_DIR}/tor-node"
  mkdir ${TorNodeDir}

  # Create bitcoin.conf
  BITCOIN_CONF="${TorNodeDir}/bitcoin.conf"
  touch $BITCOIN_CONF

  # Add settings to bitcoin.conf
  prune_target ${BITCOIN_CONF}   # prune block data
  add_tor $BITCOIN_CONF          # Add tor connections
  only_tor $BITCOIN_CONF         # Only connect through tor
  tor_seeds $BITCOIN_CONF        # Add tor seed nodes

  # Run node
  run_node ${TorNodeDir}

  # TODO: check that node successfully runs
  echo "${BOLD}[1/3]:${RESET} Generate Tor Node"

  # Let node get 15 connections
  local connection=15
  echo "${BOLD}[2/3]:${RESET} Let Node connect to ${connection} peers"
  check_peers ${TorNodeDir} ${connection}

  # Get peer info
  local peer_info=$(run_rpc ${TorNodeDir} "getpeerinfo")

  # Log peer info
  CURRENT_TEST_LOG["peers"]=$peer_info

  test_success
}

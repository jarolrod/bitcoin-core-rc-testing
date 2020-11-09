#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Generates bitcoind nodes

generate_nodes() {
# Node Variables
local x=0
local port=1111
local rpc_port=2222

# Value Arrays
BITCOIND=()              # bitcoind nodes
BITCOINCLI=()            # bitcoin-cli reference
NODES=()                 # collection of node names

echo "${BOLD}Generating Nodes"

cd ${BTC_SRC}

while [ $x -lt $1 ]
do
  # echo "node$x"
  NODES+=("node$x")
  mkdir ./${NODES[$x]}

  # Generate and Run a node
  BITCOIND+=("bitcoind -regtest\
  -port=$port -datadir=./${NODES[$x]}\
  -rpcport=${rpc_port} --daemon")

  # Generate a bitcoin-cli reference to the node
  BITCOINCLI+=("bitcoin-cli -regtest\
  -datadir=${BTC_SRC}/${NODES[$x]} -rpcport=${rpc_port}")

  # run node
  if $(./${BITCOIND[$x]}); then
    # Increment variables
    ((port++))
    ((rpc_port++))
    ((x++))
    echo "${SUCCESS} Generated Node [${x}/${1}]"

  # Error in running node
  else
    echo "Fatal Error"
    exit
  fi
done
}

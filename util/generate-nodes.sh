#!/bin/bash

generate_nodes() {
# Node Variables
x=0
PORT=1111
RPC_PORT=2222
echo "Generating Nodes:"

while [ $x -lt $1 ]
do
  #echo "node$x"
  NODES+=("node$x")
  mkdir ./${NODES[$x]}

  # Generate and Run a node
  BITCOIND+=("bitcoind -regtest\
  -port=$PORT -datadir=./${NODES[$x]}\
  -rpcport=${RPC_PORT} --daemon")

  # Generate a bitcoin-cli reference to the node
  BITCOINCLI+=("bitcoin-cli -regtest\
  -datadir=./${NODES[$x]} -rpcport=${RPC_PORT}")

  # run node
  if ./bin/${BITCOIND[$x]}; then
    # Increment variables
    PORT=$((PORT + 1))
    RPC_PORT=$((RPC_PORT + 1))
    x=$((x + 1))

    echo "Generated Node ${x} of ${1}"

  # Error in running node
  else
    echo "Fatal Error"
    exit
  fi
done
}

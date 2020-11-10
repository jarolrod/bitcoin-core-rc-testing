#!/bin/bash

# A collection of Scripts to automate Bitcoin RPC commands using regtest
# Copyright (C) 2020 Jarol Rodriguez <jarolrod@tutanota.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program (LICENSE).
# If not, see <http://www.gnu.org/licenses/>.

generate_nodes() {
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

  # Error in running node
  else
    echo "error"
  fi
done
}

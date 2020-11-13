#!/bin/bash
BITCOIN_VER="Bitcoin Core 0.20.1"
BITCOIN_SOURCE="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1.tar.gz"
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
BITCOIN_ZIP="bitcoin-0201.tar.gz"

# Default Values
NUM_NODES=3                               # Default: Generate three nodes

# Important Directories
SCRIPT_DIR=$PWD                           # Script home directory
UTIL_DIR="$SCRIPT_DIR/util"               # Util scripts
TEST_DIR="$SCRIPT_DIR/tests"              # Test RPC Commands Scripts
REGTEST_DIR="$SCRIPT_DIR/regtest"         # Regtest Directory
BITCOIN_DIR="${REGTEST_DIR}/bitcoin"      # Bitcoin Release or Git Master

# Value Arrays
BITCOIND=()                               # bitcoind nodes
BITCOINCLI=()                             # bitcoin-cli reference
NODES=()                                  # collection of node names

# Source Utilities
source "${UTIL_DIR}/help.sh"              # Help messages
source "${UTIL_DIR}/get-sys.sh"           # Determine system type
source "${UTIL_DIR}/configure.sh"         # Configure Script options
source "${UTIL_DIR}/compile-btc.sh"       # Configure Script options
source "${UTIL_DIR}/ask-permission.sh"    # Ask permission to perform task
source "${UTIL_DIR}/node-warmup.sh"       # Node Warmup Time
source "${UTIL_DIR}/download-btc.sh"      # Download Bitcoin
source "${UTIL_DIR}/unpack-btc.sh"        # Unarchive Bitcoin
source "${UTIL_DIR}/generate-nodes.sh"    # Generate bitcoind nodes
source "${UTIL_DIR}/run-rpc.sh"           # run an rpc command
source "${UTIL_DIR}/source-tests.sh"      # source all in test directory
source "${UTIL_DIR}/run-tests.sh"         # run all rpc tests
source "${UTIL_DIR}/cleanup.sh"         # run all rpc tests

# Parse option flags and args
while getopts 'h' option; do
  case "$option" in
    # Show Help screen
    h)  help;;
    # Unkown Command: Show help
    *)  help;;
  esac
done

# Get system type
get_sys

# Configure script options
configure

# Download Bitcoin
# Function asks for permission
# exit if permission not granted
download_btc

# unarchive Bitcoin
unpack_btc

# compile bitcoin if user downloaded source
if [ $COMPILE = 1 ]; then
  compile_btc
  BTC_SRC="${BITCOIN_DIR}/src"
fi

# Generate nodes
generate_nodes $NUM_NODES

# Wait for RPC to warm up
node_warmup

# source tests
cd $SCRIPT_DIR
source_tests

#run tests
run_tests

# Send data if enabled
#if $COLLECT_DATA; then
  #send_data
#fi

# Clean Up
cleanup

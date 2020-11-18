#!/bin/bash
BITCOIN_VER="Bitcoin Core 0.20.1"
BITCOIN_SOURCE="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1.tar.gz"
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
RELEASE_SIG="https://bitcoincore.org/bin/bitcoin-core-0.20.1/SHA256SUMS.asc"
BITCOIN_ZIP="bitcoin-0201.tar.gz"

# Default Values
NUM_NODES=3                               # Default: Generate three nodes
MINE=0                                    # Disable mining by default
BLOCK_TIME=4                              # Default Block Time
# Important Directories
SCRIPT_DIR=$PWD                           # Script home directory
UTIL_DIR="$SCRIPT_DIR/util"               # Util scripts
TEST_DIR="$SCRIPT_DIR/tests"              # Test RPC Commands Scripts
REGTEST_DIR="$SCRIPT_DIR/regtest"         # Regtest Directory

# Source Utilities
for dir in ${UTIL_DIR}/*;
do
  for util in ${dir}/*;
  do
    source $util;
  done
done

# Parse option flags and args
while getopts 'h' option; do
  case "$option" in
    # Show Help screen
    h)  help;;
    # Unkown Command: Show help
    *)  help;;
  esac
done

# Get system info
get_sys_info

# Configure script options
configure

# Download Bitcoin
# Function asks for permission
# exit if permission not granted
download_btc

# unarchive Bitcoin
# check for valid signatur before unpacking Release
if (check_rel_sig); then
  unpack_btc
fi

# Generate nodes
generate_nodes $NUM_NODES

# Wait for RPC to warm up
node_warmup

# source tests
cd $SCRIPT_DIR
run_tests


# Send data if enabled
#if $COLLECT_DATA; then
  #send_data
#fi

# Clean Up
cleanup

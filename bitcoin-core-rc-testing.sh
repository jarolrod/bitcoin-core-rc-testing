#!/bin/bash
BITCOIN_VER="Bitcoin Core 0.20.1"
# Download source in order to test 0.21 features
BITCOIN_SOURCE="https://github.com/bitcoin/bitcoin/archive/v0.21.0rc2.tar.gz"
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
RELEASE_SIG="https://bitcoincore.org/bin/bitcoin-core-0.20.1/SHA256SUMS.asc"


# Default Values
NUM_NODES=3                               # Default: Generate three nodes
MINE=0                                    # Disable mining by default
BLOCK_TIME=4                              # Default Block Time

# Important Directories
SCRIPT_DIR=$PWD                           # Script home directory
UTIL_DIR="$SCRIPT_DIR/util"               # Util scripts
TEST_DIR="$SCRIPT_DIR/tests"              # Test RPC Commands Scripts
REGTEST_DIR="$SCRIPT_DIR/regtest"         # Regtest Directory
DATA_DIR="$REGTEST_DIR/data"              # Script data directory

# Source Utilities
for dir in ${UTIL_DIR}/*;
do
  for util in ${dir}/*;
  do
    . $util;
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


# run cleanup on ctrl+c signal
trap ctrl+c SIGINT

# Get system info
get_sys_info

# Configure script options
configure

# Download Bitcoin
download_btc

# check for valid signature before unpacking Release
check_rel_sig

# unarchive Bitcoin
unpack_btc

# source tests
cd $SCRIPT_DIR
run_tests

# Send data if enabled
#if $COLLECT_DATA; then
  #send_data
#fi

cleanup

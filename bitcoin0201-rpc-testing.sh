#!/bin/bash
BITCOIN_VER="Bitcoin Core 0.20.1"
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
BITCOIN_ZIP="bitcoin-0201.tar.gz"

# Default Script Values
COLLECT_DATA='false'                      # Default: Do not collect data
DOWNLOAD_BITCOIN='true'                   # Default: Download Bitcoin
NUM_NODES=3                               # Default: Generate three nodes
SYS_TYPE=""                               # Default: Unknown system type

# Important Directories
SCRIPT_DIR=$(dirname "$0")                # Script home directory
UTIL_DIR="$SCRIPT_DIR/util"               # Util scripts
TEST_DIR="$SCRIPT_DIR/tests"              # Test cases
REGTEST_DIR="$SCRIPT_DIR/regtest"         # Regtest Directory
BITCOIN_DIR="${REGTEST_DIR}/bitcoin"      # location of Bitcoin Release

# Value Arrays
BITCOIND=()                               # bitcoind nodes
BITCOINCLI=()                             # bitcoin-cli reference
NODES=()                                  # collection of node names

# Source Utilities
source "${UTIL_DIR}/help.sh"              # Help messages
source "${UTIL_DIR}/get-sys.sh"           # Determine system type
source "${UTIL_DIR}/ask-permission.sh"    # Ask user for explicit permission
source "${UTIL_DIR}/download-release.sh"  # Download Bitcoin 0.20.1 release
source "${UTIL_DIR}/progress-bar.sh"
source "${UTIL_DIR}/unpack-release.sh"    # Unarchive Bitcoin Release
source "${UTIL_DIR}/generate-nodes.sh"    # Generate bitcoind nodes
source "${UTIL_DIR}/run-rpc.sh"           # run an rpc command

# Parse option flags and args
while getopts 'ch' option; do
  case "$option" in
    # User is opting to provide test diagnostics
    c)  $COLLECT_DATA='true';;
    # Show Help screen
    h)  help;;
    # Unkown Command: Show help
    *)  help;;
  esac
done

# Get system type
get_sys

# Download proper bitcoin release
# Function asks for permission
# exit if permission not granted
cd $REGTEST_DIR
download_release

# unarchive Bitcoin Release
unpack_release

# Generate nodes
cd ./bitcoin
generate_nodes $NUM_NODES

# Allow Bitcoin Nodes to warm up


# Beging Mining Function


# Load and Run RPC command tests
#run-tests

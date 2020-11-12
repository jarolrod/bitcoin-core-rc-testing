#!/bin/bash
BITCOIN_VER="Bitcoin Core 0.20.1"
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
BITCOIN_ZIP="bitcoin-0201.tar.gz"

# Default Script Values
COLLECT_DATA='false'                      # Default: Do not collect data
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

# Stylized Output
RED=$(tput setaf 1)                       # Red text output color
GREEN=$(tput setaf 2)                     # Green text output color
BLUE=$(tput setaf 4)                      # Blue text output color
RESET=$(tput sgr0)                        # Reset text output color
BOLD=$(tput bold)                         # Bold string
SUCCESS="${BOLD}${GREEN}Success:${RESET}" # Success format string
FAILURE="${BOLD}${RED}Failure:${RESET}"   # Failure format string

# Source Utilities
source "${UTIL_DIR}/help.sh"              # Help messages
source "${UTIL_DIR}/get-sys.sh"           # Determine system type
source "${UTIL_DIR}/node-warmup.sh"       # Node Warmup Time
source "${UTIL_DIR}/download-release.sh"  # Download Bitcoin 0.20.1 release
source "${UTIL_DIR}/unpack-release.sh"    # Unarchive Bitcoin Release
source "${UTIL_DIR}/generate-nodes.sh"    # Generate bitcoind nodes
source "${UTIL_DIR}/run-rpc.sh"           # run an rpc command
source "${UTIL_DIR}/run-tests.sh"         # run all rpc tests

# Source Tests


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

# Wait for RPC to warm up
node_warmup

# source tests
source-tests

#run tests
run_tests

# Send data if enabled
#if $COLLECT_DATA; then
  #send_data
#fi

# Clean Up
#cleanup

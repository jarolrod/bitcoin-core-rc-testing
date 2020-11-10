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
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
BITCOIN_ZIP="bitcoin-0201.tar.gz"

# Default Script Values
COLLECT_DATA='false'            # Default: Do not collect data
DOWNLOAD_BITCOIN='true'         # Default: Download Bitcoin
NUM_NODES=2                     # Default: Generate two nodes
SYS_TYPE=""                     # Default: Unknown system type

# Important Directories
SCRIPT_DIR=$(dirname "$0")      # Script home directory
UTIL_DIR="$SCRIPT_DIR/util"     # Util scripts
TEST_DIR="$SCRIPT_DIR/tests"    # Test cases
BITCOIN_DIR=""                  # location of Bitcoin Release

# Value Arrays
BITCOIND=()                     # bitcoind nodes
BITCOINCLI=()                   # bitcoin-cli reference to a bitcoind node
NODES=()                        # collection of node names

# Source Utilities
source "${UTIL_DIR}/help.sh"              # Help messages
source "${UTIL_DIR}/get-sys.sh"           # Determine system type
source "${UTIL_DIR}/ask-permission.sh"    # Ask user for explicit permission
source "${UTIL_DIR}/setup-test-dir.sh"    # Setup script's working dir
source "${UTIL_DIR}/download-release.sh"  # Download Bitcoin 0.20.1 release
source "${UTIL_DIR}/unpack-release.sh"    # Unarchive Bitcoin Release
source "${UTIL_DIR}/generate-nodes.sh"    # Generate bitcoind nodes
source "${UTIL_DIR}/run-rpc.sh"           # run an rpc command

# Parse option flags and args
while getopts 'rn:d:h' option; do
  case "$option" in
    # User is opting to provide test diagnostics
    r)  $RELAY_DATA='true';;
    # User will specify number of nodes
    n)  $NUM_NODES=${OPTARG};;
    # User will provide their own bitcoin download
    d)  $DOWNLOAD_BITCOIN='false'
        $BITCOIN_DOWNLOAD_DIRECTORY=${OPTARG};;
    # Show Help screen
    h)  help;;
    # Unkown Command: Show help
    *)  help;;
  esac
done

# Get system type
get_sys

if $DOWNLOAD_BITCOIN; then
  # Create a directory for script to work in
  # Function asks for permission
  # exit if permission not granted
  setup_test_dir

  # Download proper bitcoin release
  # Function asks for permission
  # exit if permission not granted
  cd $BITCOIN_DIR
  download_release

  # unarchive bitcoin release
  unpack_release
fi

# Generate nodes
#generate_nodes

# Load and Run RPC command tests
#run-tests

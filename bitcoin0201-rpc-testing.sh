BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
BITCOIN_ZIP="bitcoin-0201.tar.gz"
BITCOIN_DIR="bitcoin-0.20.1"

# Array of bitcoind Nodes
BITCOIND=()
# Reference to bitcoind nodes via bitcoin-cli
BITCOINCLI=()
# Keep track of node dirs
NODES=()
SYS_TYPE=""
script_directory=$(dirname "$0")

source "${script_directory}/util/get-sys.sh"
source "${script_directory}/util/download-release.sh"
source "${script_directory}/util/unpack-release.sh"
source "${script_directory}/util/run-rpc.sh"
source "${script_directory}/util/generate-nodes.sh"


# make directory for test
mkdir regtest
cd regtest
get_sys
download_release
unpack_release
cd $BITCOIN_DIR
generate_nodes 6
test=$(run_rpc 1 "getbalance")
echo $test

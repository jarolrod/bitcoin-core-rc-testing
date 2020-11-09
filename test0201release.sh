# Links
BITCOIN_LINUX="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-x86_64-linux-gnu.tar.gz"
BITCOIN_MAC="https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-osx64.tar.gz"
CHOOSE_BITCOIN_RELEASE="https://bitcoincore.org/en/download/"

# Declarations
$BITCOIN_ZIP="bitcoin-0201.tar.gz"
$BITCOIN_DIR="bitcoin-0201"

# Determine System Type
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)   machine=LINUX;;
    Darwin*)  machine=MAC;;
    CYGWIN*)  machine=CYGWIN;;
    MINGW*)   machine=MINGW;;
    *)        machine=UNKNOWN;;
esac
SYS_TYPE=${machine}

# Array of bitcoind Nodes
BITCOIND=()
# Reference to bitcoind nodes via bitcoin-cli
BITCOINCLI=()
# Keep track of node dirs
NODES=()


# Helper Function to unpack Bitcoin
unpack_release() {
  # Test for Bitcoin Archive File in CWD
  if test -f "$BITCOIN_ZIP"; then
    echo "Found Bitcoin Archive File"
      # Begin to unpack release
      case $SYS_TYPE in
        LINUX)  tar -xzf $BITCOIN_ZIP;;
        MAC)    tar -xzf $BITCOIN_ZIP;;
      esac
  # No Bitcoin Archive File found in CWD -> should not happen
  else
    open_info $CHOOSE_BITCOIN_RELEASE
  fi
}

# Function to download and unpack Bitcoin
download_release() {
  case $SYS_TYPE in
    LINUX)  curl $BITCOIN_LINUX -o "bitcoin.tar.gz";;
    MAC)    curl $BITCOIN_MAC -o "bitcoin.tar.gz";;
  esac
}

# Generate N number of Nodes
generate_nodes() {
  x=0
  PORT=1111
  RPC_PORT=2222
  echo "Generating Nodes"
  while [ $x -l $1 ]
  do
    # Generate and store a new data directory for the node
    NODES+=("node${x}")
    mkdir ./${NODES(${x})}

    # Generate and Run a bitcoind node
    BITCOIND+=("bitcoind -regtest \
                -port=${PORT} \
                -datadir=./${node_name} \
                -rpcport=${RPC_PORT} \
                -- daemon")

    # Run the new bitcoind node - Test for run
    if ./bin/${BITCOIND(${x})}; then
      # Node is running: Generate a bitcoin-cli reference
      BITCOINCLI+=("bitcoincli -regtest \
                    -datadir=./${node_name} \
                    -rpcport=${RPC_PORT} $@")

      # Test for connection to bitcoind node
      if ./bin/"${BITCOINCLI(${x})} getblock"; then
        # Node is running and bitcoincli reference works
        echo "generated node${x}"
        # Increment variables
        x=$(($x + 1))
      fi
    # error - exit
    else
      echo "something went wrong"
  done
}

mkdir bitcoin-testing
cd ./bitcoin-testing
TEST_DIRECTORY=$(pwd)

# Download Bitcoin Release
download_release

# Unpack Bitcoin release
unpack_release

# Change Directory to Bitcoin Release Directory
cd $BITCOIN_DIR

touch testoutput.txt
mkdir nodes

# Generate five nodes
generate_nodes 5

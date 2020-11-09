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
    echo "error"
  fi
}

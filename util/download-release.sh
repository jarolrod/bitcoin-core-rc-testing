download_release() {
  case $SYS_TYPE in
    LINUX)  curl $BITCOIN_LINUX -o $BITCOIN_ZIP;;
    MAC)    curl $BITCOIN_MAC -o $BITCOIN_ZIP;;
  esac
}

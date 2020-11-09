get_sys() {
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
}

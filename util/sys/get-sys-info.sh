#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Determine System Type

get_sys_info() {
  # Note: Need to be more inclusive of other systems
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)   machine=LINUX;;
      Darwin*)  machine=MAC;;
      *)        machine=UNKNOWN;;
  esac
  SYS_TYPE=${machine}

  # Gather additional info: System Dependent
  if [ $SYS_TYPE = "MAC" ]; then
    mac_sys_info
  else
    #linux_sys_info
    linux_sys_info
  fi

  # Write collected System Informatio
  write_sys_info
}

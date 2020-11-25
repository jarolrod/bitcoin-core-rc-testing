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
  [ $SYS_TYPE = "MAC" ] && mac_sys_info       # Mac System
  [ $SYS_TYPE = "LINUX" ] && linux_sys_info   # Linux system

  # Write collected System Informatio
  write_sys_info
}

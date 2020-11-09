#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Collect System Information on a Mac machine

mac_sys_info() {
  local name=$(sw_vers -productName)
  local version=$(sw_vers -productVersion)
  local build=$(sw_vers -buildVersion)
  OS="${name} ${version}-${build}"
  PROCESSOR=$(sysctl -n machdep.cpu.brand_string | xargs)
  KERNEL=$(sysctl -n kern.osrelease)
}

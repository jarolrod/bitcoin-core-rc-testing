#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Collect System Information on a Linux machine

linux_sys_info() {
  local name=$(lsb_release -a | grep "Description" | sed -r 's/Description:\s{1,}//g')
  local version=$(lsb_release -a | grep "Release" | sed -r 's/Release:\s{1,}//g')
  local build=$(lsb_release -a | grep "Codename" | sed -r 's/Codename:\s{1,}//g')
  OS="${name} ${version}-${build}"
  PROCESSOR=$(lscpu | grep "Model name:" | sed -r 's/Model name:\s{1,}//g')
  KERNEL=$(uname -r)
}

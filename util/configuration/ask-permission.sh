#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Use with permissioned tasks

ask_permission() {
  CHOICE=''
  local prompt="$1"
  while true; do
    read -p "$prompt" yn
    case $yn in
      [yY1] ) CHOICE=1
              break;;
      [nN0] ) CHOICE=0
              break;;
      * )  echo "Please answer (y)es or (n)o:";;
    esac
  done
}

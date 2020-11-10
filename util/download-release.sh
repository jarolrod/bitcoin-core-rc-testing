#!/bin/bash

# A collection of Scripts to automate Bitcoin RPC commands using regtest
# Copyright (C) 2020 Jarol Rodriguez <jarolrod@tutanota.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program (LICENSE).
# If not, see <http://www.gnu.org/licenses/>.

download_release() {

  # Ask for permission to begin download
  echo "Script needs to download the Bitcoin 0.20.1 release"
  answer=$(ask_permission)
  if answer=true; then
    case $SYS_TYPE in
      LINUX)  curl $BITCOIN_LINUX -o $BITCOIN_ZIP;;
      MAC)    curl $BITCOIN_MAC -o $BITCOIN_ZIP;;
    esac

  else
    echo "error"
  fi

}

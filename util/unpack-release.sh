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

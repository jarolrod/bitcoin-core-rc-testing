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

setup_test_dir() {
  # We will be making a regtest directory
  # Ask permission
  echo "Script needs to create regtest directory"
  answer=$(ask_permission)
  if answer=true; then
      # Check that there is not one already existing
      echo "${SCRIPT_DIR}/regtest"
    #if [ ! -d "${SCRIPT_DIR}/regtest"]; then
      mkdir ./regtest

      # This is where we will download bitcoin
      $BITCOIN_DIR="$SCRIPT_DIR/regtest"
  else
    echo "error"
    #fi
    #  echo "error"
  fi
}

#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# make node only connect through tor

only_tor() {
  echo "onlynet=onion" >> ${1}
}

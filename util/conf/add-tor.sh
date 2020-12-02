#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# add standard tor settings to bitcoin.conf

add_tor() {
  # Tor Configuration
  echo "proxy=127.0.0.1:9050" >> ${1}   # could differ
  echo "listen=1"  >> ${1}
  echo "bind=127.0.0.1" >> ${1}
}

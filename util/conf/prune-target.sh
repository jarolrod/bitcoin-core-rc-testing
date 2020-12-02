#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# set prune target for node

prune_target() {
  echo "prune=550" >> ${1}
}

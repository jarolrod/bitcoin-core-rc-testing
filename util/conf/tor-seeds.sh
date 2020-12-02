#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# add tor seed nodes to bitcoin.conf

tor_seeds() {
  echo "seednode=wxvp2d4rspn7tqyu.onion" >> ${1}
  echo "seednode=bk5ejfe56xakvtkk.onion" >> ${1}
  echo "seednode=bpdlwholl7rnkrkw.onion" >> ${1}
  echo "seednode=hhiv5pnxenvbf4am.onion" >> ${1}
  echo "seednode=4iuf2zac6aq3ndrb.onion" >> ${1}
  echo "seednode=nkf5e6b7pl4jfd4a.onion" >> ${1}
  echo "seednode=xqzfakpeuvrobvpj.onion" >> ${1}
  echo "seednode=tsyvzsqwa2kkf6b2.onion" >> ${1}
}

#!/bin/bash
function compile_btc {
  ./autogen.sh
  ./configure
  make -j 5
}

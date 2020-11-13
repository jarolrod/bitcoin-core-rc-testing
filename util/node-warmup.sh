#!/bin/bash

node_warmup () {
  c=1 # seconds to wait
  echo "${BOLD}Nodes are warming up"
  REWRITE=". "
  while [ $c -le 5 ]; do
      c=$((c+1))
      echo -ne "${REWRITE}"
      sleep 1
      REWRITE+=". "
  done
}

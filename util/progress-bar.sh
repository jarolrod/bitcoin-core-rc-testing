#!/bin/bash

progress_bar() {
  local w=5 p=$1; shift
  printf -v dots "%*s" "$(( $p*$w/3 ))" ""; dots=${dots// /.};
  printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*";
}

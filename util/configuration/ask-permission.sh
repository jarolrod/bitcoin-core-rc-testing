#!/bin/bash

function ask_permission {
  CHOICE=''
  local prompt="$1"
  while true; do
    read -p "$prompt" yn
    case $yn in
      [yY1] ) CHOICE=1
              break;;
      [nN0] ) CHOICE=0
              break;;
      * )  echo "Please answer (y)es or (n)o:";;
    esac
  done
}

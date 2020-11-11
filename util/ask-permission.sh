#!/bin/bash

# Function will ask for Y/N input and return t/f
ask_permission() {
  echo "Do you give permission?: <y/n>"
  while true; do
    read yn
    case $yn in
      # User has entered: Yes
      [Yy]*)  echo true
              break;;

      # User has entered: No
      [Nn]*)  echo false
              break;;

      *)      echo "Please answer yes or no: <y/n>";;

    esac
  done
}

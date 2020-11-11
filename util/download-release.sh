#!/bin/bash

download_release() {
  # Ask for permission to begin download
  echo "Script needs to download the ${BITCOIN_VER} release"
  echo "Do you give permission?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes)  # We have permission

            curl $BITCOIN_MAC -o $BITCOIN_ZIP
            break;;
      No)   # Permission not given
            echo "Error: No Bitcoin Release to work with"
            echo "Please provide a Release directory, or give permission"
            exit;;
    esac
  done
}

#!/bin/bash

download_release() {
  # Ask for permission to begin download
  echo "${BOLD}Script needs to download the ${BITCOIN_VER} Release"
  echo "Do you give permission?${RESET}"
  select yn in "Yes" "No"; do
    case $yn in
      "Yes")  # We have permission
            echo "${BOLD}Downloading the ${BITCOIN_VER} release for ${SYS_TYPE}\
                  ${BLUE}"
            case $SYS_TYPE in
              LINUX)  curl --progress-bar $BITCOIN_LINUX -o $BITCOIN_ZIP
                      break;;

              MAC)    curl --progress-bar $BITCOIN_MAC -o $BITCOIN_ZIP
                      break;;
            esac

            ;;
      "No")   # Permission not given
            echo "${FAILURE}: No Bitcoin Release to work with"
            echo "${RED}Please provide a Release directory, or give permission\
                  ${RESET}"
            exit;;
    esac
  done
}

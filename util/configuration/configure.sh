#!/bin/bash

function configure {
  # Configure: Bitcoin Source, Bitcoin Release, Provide
  local bit_src="${GREEN}Source Code${RESET}${BOLD}"
  local bit_rel="${GREEN}Release${RESET}${BOLD}"

  echo "${BOLD}Would you like to download the Bitcoin Source Code or Official Release:"
  select type in "$bit_src" "$bit_rel"
  do
    case $type in
      "$bit_src") # User wants to download source code
          COMPILE=1                       # We will be compiling bitcoin
          TYPE="Source Code"              # Type of bitcoin download is source
          DOWNLOAD_LINK=$BITCOIN_SOURCE   # Download link is bitcoin source
          break
          ;;

      "$bit_rel") # User wants to download binary
          COMPILE=0           # We will not be compiling bitcoin
          TYPE="Release"      # Type of bitcoin download is release
          # Download link is dependent on system type
          case $SYS_TYPE in
            LINUX)  DOWNLOAD_LINK=$BITCOIN_LINUX;;
            MAC)    DOWNLOAD_LINK=$BITCOIN_MAC;;
          esac
          break
          ;;
    esac
  done

  # Configure: Telemetry Data
  echo "Bitcoin Core Developers can benefit from your test data"
  echo "Would you like to opt-in to sending Telemetry data?"
  local yes="${GREEN}Yes${RESET}${BOLD}: Send my test data"
  local no="${RED}No${RESET}${BOLD}: Do not send my test data"
  select option in "$yes" "$no"
  do
    case $option in
      "$yes") TELEMETRY=1   # User opted in
                break;;
      "$no")  TELEMETRY=0    # User opted out
                break;;
    esac
  done

  local time_snapshot=$(date +%I:%M:%S)
  DATA_FILE=${DATA_DIR}/"data-${time_snapshot}.json"

  # Write collected System Informatio
  write_sys_info
  
  # log configuration info
  write_config_info
}

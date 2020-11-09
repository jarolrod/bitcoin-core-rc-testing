#!/usr/bin/env bash
#
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Variables useful for stylized output

# Stylized Output
RED=$(tput setaf 1)                        # Red text output color
GREEN=$(tput setaf 2)                      # Green text output color
YELLOW=$(tput setaf 3)                     # Yellow text output color
BLUE=$(tput setaf 4)                       # Blue text output color
RESET=$(tput sgr0)                         # Reset text output color
BOLD=$(tput bold)                          # Bold string
SUCCESS="${BOLD}${GREEN}Success:${RESET}"  # Success format string
FAILURE="${BOLD}${RED}Failure:${RESET}"    # Failure format string
WARNING="${BOLD}${YELLOW}Warning:${RESET}" # Warning format string 

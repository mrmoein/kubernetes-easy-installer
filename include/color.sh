#!/bin/bash


### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##
green_print() { printf "${GREEN}%s${RESET}\n" "$1"; }
blue_print() { printf "${BLUE}%s${RESET}\n" "$1"; }
red_print() { printf "${RED}%s${RESET}\n" "$1"; }
yellow_print() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magenta_print() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyan_print() { printf "${CYAN}%s${RESET}\n" "$1"; }
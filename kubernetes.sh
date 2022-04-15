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

### Functions ##
wait_for_key() {
  echo $(yellow_print "press any key to continue")
  read -r
}

### Menu ##
PS3=$(cyan_print 'Please enter your choice: ')

#worker_menu(){
#  echo $(magenta_print "Worker Menu")
#  select opt in "join" "remove" "Back"
#  do
#      case $opt in
#          "join")
#              echo "you chose choice 2"
#              ;;
#          "remove")
#              echo "you chose choice $REPLY which is"
#              ;;
#          "Back")
#              break
#              ;;
#          *) echo "invalid option $REPLY";;
#      esac
#      wait_for_key
#      REPLY=
#      echo $(magenta_print "Worker Menu")
#  done
#}
#
#
#master_menu(){
#  echo $(magenta_print "Master Menu")
#  select opt in "init master" "join master" "remove" "Back"
#  do
#      case $opt in
#          "init")
#              echo "you chose choice 1"
#              ;;
#          "join master")
#              echo "you chose choice 2"
#              ;;
#          "join worker")
#              echo "you chose choice 2"
#              ;;
#          "remove")
#              echo "you chose choice $REPLY which is"
#              ;;
#          "Back")
#              break
#              ;;
#          *) echo "invalid option $REPLY";;
#      esac
#      wait_for_key
#      REPLY=
#      echo $(magenta_print "Master Menu")
#  done
#}

install_kubernetes_requirements() {
  #  REQUIRED_PKG="nginxx"
  #  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")
  #  echo Checking for $REQUIRED_PKG: $PKG_OK
  #  if [ "" = "$PKG_OK" ]; then
  #    echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  #    sudo apt-get --yes install $REQUIRED_PKG
  #  fi
  sudo apt update
  sudo apt upgrade -y
  # is docker installed
  REQUIRED_PKG='docker'
  PKG_OK=$(docker -v | grep "Docker version")
  echo Checking for $REQUIRED_PKG: $PKG_OK
  if [ "" = "$PKG_OK" ]; then
    echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
    sudo apt install docker.io -y
  fi
}

select opt in "install kubernetes requirements" "init master" "create join data" "join to cluster" "help" "quit"; do
  case $opt in
  "install kubernetes requirements")
    install_kubernetes_requirements
    ;;
  "init master")
    break
    ;;
  "create join data")
    break
    ;;
  "join to cluster")
    break
    ;;
  "help")
    break
    ;;
  "quit")
    break
    ;;
  *)
    echo $(red_print "invalid option $REPLY")
    wait_for_key
    ;;
  esac
  REPLY=
done

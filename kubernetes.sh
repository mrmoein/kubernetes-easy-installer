#!/bin/bash
source include/utils.sh
source include/color.sh
source include/functions.sh
source include/install_kubernetes_requirements.sh
source include/init_master.sh
source include/create_join_command.sh

### Menu ##
PS3=$(cyan_print 'Please enter your choice: ')

select opt in "install kubernetes requirements" "init master" "create join command" "join to cluster" "help" "quit"; do
  case $opt in
  "install kubernetes requirements")
    install_kubernetes_requirements
    ;;
  "init master")
    init_master
    ;;
  "create join command")
    create_join_command
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
    ;;
  esac
  REPLY=
  wait_for_key
done

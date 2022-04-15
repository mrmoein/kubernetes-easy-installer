#!/bin/bash

### Functions ##
wait_for_key() {
  echo $(yellow_print "press any key to continue")
  read -r
}

run(){
  if [ "" != "$1" ]; then
    magenta_print "run: $1"
    eval "$1"
  fi
}
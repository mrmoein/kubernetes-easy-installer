#!/bin/bash

### Functions ##
wait_for_key() {
  echo $(yellow_print "press any key to continue")
  read -r
}

run() {
  if [ "" != "$1" ]; then
    blue_print "➜ $1"
    eval "$1"
  fi
}

check_pkg_is_installed() {
  PKG_OK=$(eval "$1" | grep "$2")
  if [ "" = "$PKG_OK" ]; then
    return 1
  else
    return 0
  fi
}

echo_pkg_status() {
  if check_pkg_is_installed "$1" "$2"; then
    e_success "$3 are installed and work correctly"
  else
    e_error "$3 not installed or work correctly"
  fi
}
#!/bin/bash

create_join_command() {
  if ! check_pkg_is_installed "kubeadm version" "kubeadm version"; then
    e_error "kubeadm not installed!"
    return 0
  fi

  # read Ignore SystemVerification preflight errors
  while true; do
    read -p 'Ignore SystemVerification preflight errors (Y/N): ' ignore_preflight_errors
    if [ "Y" = "$ignore_preflight_errors" ] || [ "N" = "$ignore_preflight_errors" ]; then
      break
    fi
    red_print "Input is incorrect, must be 'Y' or 'N'"
  done

  JOIN_COMMAND=$(kubeadm token create --print-join-command)

  if [ "Y" = "$ignore_preflight_errors" ]; then
    JOIN_COMMAND+=" --ignore-preflight-errors=SystemVerification"
  fi

  CERT_KEY=$(kubeadm init phase upload-certs --upload-certs | sed '3!d')

  JOIN_COMMAND_MASTER="$JOIN_COMMAND --control-plane --certificate-key $CERT_KEY"

  e_arrow "Worker Join: $JOIN_COMMAND"
  e_arrow "Master Join: $JOIN_COMMAND_MASTER"
}

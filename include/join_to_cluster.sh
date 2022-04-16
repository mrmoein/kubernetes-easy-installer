#!/bin/bash

join_to_cluster() {
  if ! check_pkg_is_installed "kubeadm version" "kubeadm version"; then
    e_error "kubeadm not installed!"
    return 0
  fi

  # read Network Plugin
  read -p "Enter the join command: " join_command

  run "$join_command"

  NODE_TYPE=$(echo "$join_command" | grep "\--control-plane")

  # if node are master config kubectl
  if [ "" != "$NODE_TYPE" ]; then
    echo 'yes'
    return 0
    run "mkdir -p $HOME/.kube"
    run "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
    run "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
  fi
}

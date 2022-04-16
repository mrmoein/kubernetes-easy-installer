#!/bin/bash

join_to_cluster() {
  if ! check_pkg_is_installed "kubeadm version" "kubeadm version"; then
    e_error "kubeadm not installed!"
    return 0
  fi

  # read Network Plugin
  read -p "Enter the join command: " join_command

  run "$join_command"

  # if node are master config kubectl
  if check_pkg_is_installed "echo $join_command" "\--control-plane"; then
    run "mkdir -p $HOME/.kube"
    run "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
    run "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
  fi
}

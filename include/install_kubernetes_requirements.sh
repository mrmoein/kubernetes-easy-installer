#!/bin/bash

install_kubernetes_requirements() {
  run "sudo apt update"
  run "sudo apt upgrade -y"

  # is docker installed
  if ! check_pkg_is_installed "docker -v" "Docker version"; then
    run "sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release"
    run "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
    run "echo  \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
    run "sudo apt update -y"
    run "sudo apt install docker-ce docker-ce-cli containerd.io -y"
    run 'cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}'
    run "sudo systemctl enable docker"
    run "sudo systemctl daemon-reload"
    run "sudo systemctl restart docker"
  fi

  # is kubeadm requirements installed
  if ! check_pkg_is_installed "kubeadm version" "kubeadm version"; then
    run "sudo apt install -y apt-transport-https curl gnupg-agent software-properties-common"
    run "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add"
    run "sudo apt-add-repository \"deb http://apt.kubernetes.io/ kubernetes-xenial main\""
    run "sudo apt install -y kubelet kubeadm kubectl"
  fi

  # make swap off
  run "sudo swapoff -a"
  run "sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"

  # check docker status
  echo_pkg_status "docker run hello-world" "Hello from Docker!" "Docker"

  # check Kubeadm status
  echo_pkg_status "kubeadm version" "kubeadm version" "Kubeadm requirements"
}
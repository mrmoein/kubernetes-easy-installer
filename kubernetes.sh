#!/bin/bash
source include/utils.sh
source include/color.sh
source include/functions.sh

### Menu ##
PS3=$(cyan_print 'Please enter your choice: ')

install_kubernetes_requirements() {
  run "sudo apt update"
  run "sudo apt upgrade -y"

  # is docker installed
  PKG_OK=$(docker -v | grep "Docker version")
  if [ "" = "$PKG_OK" ]; then
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
  # check docker status
  PKG_OK=$(docker run hello-world | grep "Hello from Docker!")
  if [ "" = "$PKG_OK" ]; then
    e_success "Docker are installed and work correctly"
  else
    e_error "Docker not installed or work correctly"
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

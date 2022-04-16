#!/bin/bash

init_master() {
  # read control_plane_endpoint
  read -p 'control plane endpoint (load balancer DNS/load balancer ip): ' control_plane_endpoint

  # read Network Plugin
  echo "Select Network Plugin:"
  select opt in "Flannel" "Calico"; do
    case $opt in
    "Flannel")
      POD_NETWORK="10.244.0.0/16"
      POD_NETWORK_CNI="Flannel"
      break
      ;;
    "Calico")
      POD_NETWORK="192.168.0.0/16"
      POD_NETWORK_CNI="Calico"
      break
      ;;
    *)
      echo $(red_print "invalid option $REPLY")
      ;;
    esac
  done

  # read Ignore SystemVerification preflight errors
  while true; do
    read -p 'Ignore SystemVerification preflight errors (Y/N): ' ignore_preflight_errors
    if [ "Y" = "$ignore_preflight_errors" ] || [ "N" = "$ignore_preflight_errors" ]; then
      break
    fi
    red_print "Input is incorrect, must be 'Y' or 'N'"
  done

  run "kubeadm config images list"
  run "kubeadm config images pull"
  run "sudo systemctl daemon-reload"

  COMMAND="kubeadm init --control-plane-endpoint $control_plane_endpoint --upload-certs --pod-network-cidr=$POD_NETWORK"
  if [ "Y" = "$ignore_preflight_errors" ]; then
    COMMAND+=" --ignore-preflight-errors=SystemVerification"
  fi

  run "$COMMAND"

  run "mkdir -p $HOME/.kube"
  run "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
  run "sudo chown $(id -u):$(id -g) $HOME/.kube/config"

  run "kubectl get no"
  run "kubectl wait --for=condition=ready --all node --timeout=60s"

  if [ "Flannel" = "$POD_NETWORK_CNI" ]; then
    run "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
  elif [ "Calico" = "$POD_NETWORK_CNI" ]; then
    run "kubectl apply -f https://projectcalico.docs.tigera.io/manifests/calico.yaml"
  fi
}
NotReady
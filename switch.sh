#!/bin/bash

target_color=$1
name_space=$2
release_switch_name=$3

#kubectl apply -f kube/$target_color.yaml
export KUBECONFIG=/home/jenkins/.kube/kubeconfig_npe
helm upgrade  --wait --timeout 200 --install --set color=$target_color --namespace $name_space $release_switch_name ./switch


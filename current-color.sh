#!/bin/bash
service_name=$1
name_space=$2
export KUBECONFIG=/home/jenkins/.kube/kubeconfig_npe
kubectl get svc/$service_name -o=jsonpath='{.spec.selector.color}' --ignore-not-found=true --namespace=$name_space
#kubectl get svc/poc-helloworld-svc-switch -o=jsonpath='{.spec.selector.color}' --ignore-not-found=true --namespace=ci
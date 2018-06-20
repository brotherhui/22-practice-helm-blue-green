#!/bin/bash
target_color=$1
name_space=$2
folder_name=$3
release_name=$4
SERVER_NAME=$5
replic_num=$6

export KUBECONFIG=/home/jenkins/.kube/kubeconfig_npe
helm upgrade --namespace $name_space --wait --timeout 200 --install --set color=$target_color --set replicanum=$replic_num $release_name ./$folder_name

server_check_count=0
server_check_limit=10
server_ready=false
RUN_NUM=0
#-----------check pod server status...
while true; do
 	#kubectl get pods -a --namespace=ci |grep green-deployment |grep Running |head -n3 | cut -d " " -f1
    SERVER_POD=($(kubectl get pods -a --namespace=$name_space |grep $SERVER_NAME |grep Running |head -n$replic_num | cut -d " " -f1))
    
	if [ ! $SERVER_POD  ]; then  
       RUN_NUM=0
    else
       RUN_NUM=${#SERVER_POD[@]}
    fi 
	
    if [ $replic_num -eq $RUN_NUM ]; then
	   #------all of the server are running...
       server_ready=true
    fi
      server_check_count=$(( $server_check_count + 1))
    if [ $server_ready = true ] || [ $server_check_count -gt $server_check_limit ]; then
        break
    fi
	sleep 10
done

if [ $server_ready = false ] ; then
  echo -e "FAIL\c"
  #rollback?  
  exit
else
  echo -e"SUCCESS\c"
  exit
fi
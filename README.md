# 22-practice-helm-blue-green
blue green deployment for helm

1. First deploy the helm chart
2. switch the color

<code>
    
    def svcswitch = 'poc-helloworld-svc-switch'
    def workspace = pwd()
    def currentcolor = 'none'
    def targetcolor
    def namespace = 'ci'
    //folder name for helm, default is helm
    def foldername = 'helm-deployment-poc'
    //release name for deployment
    def releasename = 'helm-poc'
    //release name for switch
    def releaseswitchname = 'helm-svc-poc'
    def servername
    def replicnum = 3


    stage "Deploy", {
    	println workspace
    	sh "ls -l ${workspace}"
    	//we must set the kubeconfig in the same session
    	sh "chmod 700 *"
        currentcolor = sh(returnStdout: true, script: "./current-color.sh ${svcswitch} ${namespace}")
        println currentcolor
        targetcolor = sh(returnStdout: true, script: "./target-color.sh ${currentcolor}")
        println targetcolor
        servername = targetcolor+"-deployment"
        println servername
        deployed= sh(returnStdout: true, script: "./deploy.sh ${targetcolor} ${namespace} ${foldername} ${releasename} ${servername} ${replicnum}")
        println deployed
    }
    
    stage "Switch", {
       if(deployed == "SUCCESS"){
    	  println workspace
    	  sh "ls -l ${workspace}"
    	  //we must set the kubeconfig in the same session
          sh "./switch.sh ${targetcolor} ${namespace} ${releaseswitchname}"
          sh "./current-color.sh ${svcswitch} ${namespace}"
        }
    }
    
</code>

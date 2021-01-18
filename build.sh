#!/bin/bash
#sudo kubectl apply -f deployment.yaml --kubeconfig=/home/manhnh/.kube/config
# sample value for your variables
#MYVARVALUE="nginx:latest"

# read the yml template from a file and substitute the string 
# {{MYVARNAME}} with the value of the MYVARVALUE variable
template=`cat "deployment.yml.template" | sed "s/{{IMAGE}}/$IMAGE/g"`

# apply the yml with the substituted value
echo "$template" | kubectl apply -f --kubeconfig=/home/manhnh/.kube/config -

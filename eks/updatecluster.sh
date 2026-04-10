#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
M="\e[35m"
C="\e[36m"
W="\e[37m"
currentversion=1
targetvesion=2

CLUSTERNAME="roboshop-dev"
AWS_REGION="us-east-1"
EKS_TARGET_VERSION=$1  

if [ $currentversion == $targetvesion ] ; then" 
    echo "already updated so not required"
fi
    
while [ $status != "Successful" ]
do
  echo "waiting for cluster update to complete"
  sleep 30
  status=$(aws eks describe-cluster --name $CLUSTERNAME --region $AWS_REGION | jq -r '.cluster.status // "Unknown"')
done

if [$threshold -le 75 ]; then
  echo "memory is fine0"
else
  echo "memory is not fine | mail -s 'Alert: Memory Usage High'
fi 



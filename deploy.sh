#!/usr/bin/env bash
set -e

dockerComposeVersion=$1
dockerComposeImage="tianyawy/docker-secret:$1"
stackName=deploy-test
serviceName="${stackName}_webapp"
waitTime=20
totalWaitTimes=30

docker run -v $PWD/env:/export $dockerComposeImage
cd $PWD/env
echo `current work dir is $PWD`

sf=`docker service ls | grep $serviceName || echo ''`
echo "docker service is in status $sf"
isNonCreated=true
if [ ! -n "$sf" ]
then
  isNonCreated=false
fi
echo "this service is just $isNonCreated"

docker stack deploy -c docker-compose.yml $stackName

if $isNonCreated; then
  loopTimes=0
  while true; do
    updateStatus=`docker service inspect -f '{{if .UpdateStatus}}{{.UpdateStatus.State}}{{else}}completed{{end}}' $serviceName`
    echo "current status is ${updateStatus}"
   
    if [ $loopTimes = $totalWaitTimes ] 
    then
      echo "the loop times is greater than $totalWaitTimes * $waitTime"
      exit 1;
    fi
    loopTimes=loopTimes+1

    if [ $updateStatus = "completed" ]
    then
      break;
    elif [ $updateStatus = "updating" ]
    then
      sleep $waitTime;
    else
      exit 1;
    fi
  done
else
  loopTimes=0
  while true; do
    
    if [ $loopTimes = $totalWaitTimes ] 
    then
      echo "the loop times is greater than $totalWaitTimes * $waitTime"
      exit 1;
    fi
    loopTimes=loopTimes+1

    createdReplicas=`docker service ls | grep $serviceName | awk '{print $4;}' | awk -F'/' '{print $1}'`
    echo "replicas just created $createdReplicas"
    if [ $createdReplicas = "3" ]
    then
      break;
    else
      sleep $waitTime;
    fi
  done
  loopTimes=loopTimes+1
fi



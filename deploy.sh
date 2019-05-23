#!/usr/bin/env bash
set -e

dockerComposeVersion=$1
stackName=deploy-test
serviceName="${stackName}_webapp"
docker run -v $PWD/env:/export tianyawy/docker-secret:$dockerComposeVersion
cd $PWD/env
echo $PWD
docker stack deploy -c docker-compose.yml $stackName

loopTimes=0
while true; do
  updateStatus=`docker service inspect -f '{{if .UpdateStatus}}{{.UpdateStatus.State}}{{else}}completed{{end}}' $serviceName`
  echo "current status is ${updateStatus}"
  if [ $loopTimes = 30 ] 
  then
    echo "the loop times is greater than 10 min"
    exit 1;
  fi
  if [ $updateStatus = "completed" ]
  then
    break;
  elif [ $updateStatus = "updating" ]
  then
    sleep 20;
  else
    exit 1;
  fi
  loopTimes=loopTimes+1
done



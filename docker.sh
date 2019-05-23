
gradle build

docker build -t spring-health-check .

`docker tag spring-health-check:latest tianyawy/spring-health-check:$1`
pushCommand="docker push tianyawy/spring-health-check:$1"
$pushCommand

dockerComposeFile="docker build --build-arg IMAGEVERSION=$1 -f Dockerfile-env -t docker-secret ."
$dockerComposeFile

dockerComposeTagCommand="docker tag docker-secret:latest tianyawy/docker-secret:$1"
$dockerComposeTagCommand

dockerComposePushCommand="docker push tianyawy/docker-secret:$1"
$dockerComposePushCommand


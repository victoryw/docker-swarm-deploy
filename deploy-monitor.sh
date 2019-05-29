#!/usr/bin/env bash
docker run -d  --name=prometheus  --network deploy-test_mynet1 -p 9090:9090  -v $(pwd):/prometheus-config  prom/prometheus --config.file=/prometheus-config/prom-config.yml

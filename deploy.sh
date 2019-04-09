#!/bin/bash

docker build -t fango007/multi-client:latest -t fango007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fango007/multi-server:latest -t fango007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fango007/multi-worker:latest -t fango007/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fango007/multi-client:latest
docker push fango007/multi-client$SHA

docker push fango007/multi-server:latest
docker push fango007/multi-server:$SHA

docker push fango007/multi-worker:latest
docker push fango007/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=fango007/multi-server:$SHA
kubectl set image deployments/client-deployment server=fango007/multi-client:$SHA
kubectl set image deployments/worker-deployment server=fango007/multi-worker:$SHA



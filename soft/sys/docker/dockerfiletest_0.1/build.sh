#!/bin/bash

name=dockerfiletest:0.1
docker ps -a | grep ${name} | awk '{print $1}' | xargs docker stop && docker ps -a | grep ${name} | awk '{print $1}' | xargs docker rm
docker rmi ${name}
docker build -t ${name} -f Dockerfile .

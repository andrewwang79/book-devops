#!/bin/bash

name=dockerfiletest:0.1
upload_target=hub.docker.com/wangyaqi/
docker tag ${name} ${upload_target}${name}
docker push ${upload_target}${name}

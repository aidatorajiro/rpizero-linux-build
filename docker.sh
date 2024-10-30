#!/bin/bash

docker build . -t rpizero-linux-build
docker run --rm -it -v $(pwd):/rpizero-linux-build rpizero-linux-build

# In the docker, run following commands:
# cd /rpizero-linux-build
# sh build.sh

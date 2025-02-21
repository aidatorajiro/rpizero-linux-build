#!/bin/bash

set -eo pipefail

./download.sh
docker build . -t rpizero-linux-build
docker run --rm -it -v $(pwd):/rpizero-linux-build rpizero-linux-build bash -c "cd /rpizero-linux-build/ && ./clean.sh && ./build.sh"
./pack.sh
./packsend.sh

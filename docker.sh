docker build . -t rpizero-linux-build
docker run --rm -it -v $(pwd):/rpizero-linux-build rpizero-linux-build
# cd /rpizero-linux-build
# sh build.sh
#!/bin/bash
set -x
set -e
# to build your own image:
# export DOCKER_REGISTRY=quay.io/kaszpir
# ./build-docker.sh
: ${DOCKER_REGISTRY:='gradiant'}
: ${VERSION:='2.1.10'}

docker build --build-arg VERSION=$VERSION -t ${DOCKER_REGISTRY}/hbase-base:$VERSION hbase-base

docker build --build-arg VERSION=$VERSION -t ${DOCKER_REGISTRY}/hbase-master:$VERSION hbase-master
docker build --build-arg VERSION=$VERSION -t ${DOCKER_REGISTRY}/hbase-region:$VERSION hbase-region

docker tag ${DOCKER_REGISTRY}/hbase-base:$VERSION ${DOCKER_REGISTRY}/hbase-base:latest
docker tag ${DOCKER_REGISTRY}/hbase-master:$VERSION ${DOCKER_REGISTRY}/hbase-master:latest
docker tag ${DOCKER_REGISTRY}/hbase-region:$VERSION ${DOCKER_REGISTRY}/hbase-region:latest

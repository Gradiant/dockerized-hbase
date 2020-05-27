#!/bin/bash
set -x
set -e
# to build your own image:
# export HBASE_VERSION=2.2.4
# export DOCKER_REGISTRY=quay.io/kaszpir
# export HADOOP_IMAGE=quay.io/kaszpir/dockerized-hadoop:3.1.3
# ./build-docker.sh

#  hbase version
: ${HBASE_VERSION:='2.2.4'}

# docker registry for destination images
: ${DOCKER_REGISTRY:='quay.io/kaszpir'}

# docker image for hbase-* image
: ${HADOOP_IMAGE:='quay.io/kaszpir/dockerized-hadoop:3.1.3'}

docker build --build-arg version=$HBASE_VERSION --build-arg HADOOP_IMAGE=$HADOOP_IMAGE -t ${DOCKER_REGISTRY}/hbase-base:$HBASE_VERSION hbase-base

HBASE_IMAGE="${DOCKER_REGISTRY}/hbase-base:$HBASE_VERSION"
docker build --build-arg version=$HBASE_VERSION --build-arg HBASE_IMAGE=$HBASE_IMAGE -t ${DOCKER_REGISTRY}/hbase-master:$HBASE_VERSION hbase-master
docker build --build-arg version=$HBASE_VERSION --build-arg HBASE_IMAGE=$HBASE_IMAGE -t ${DOCKER_REGISTRY}/hbase-region:$HBASE_VERSION hbase-region

docker tag ${DOCKER_REGISTRY}/hbase-base:$HBASE_VERSION ${DOCKER_REGISTRY}/hbase-base:latest
docker tag ${DOCKER_REGISTRY}/hbase-master:$HBASE_VERSION ${DOCKER_REGISTRY}/hbase-master:latest
docker tag ${DOCKER_REGISTRY}/hbase-region:$HBASE_VERSION ${DOCKER_REGISTRY}/hbase-region:latest


docker push ${DOCKER_REGISTRY}/hbase-base:$HBASE_VERSION
docker push ${DOCKER_REGISTRY}/hbase-base:latest
docker push ${DOCKER_REGISTRY}/hbase-master:$HBASE_VERSION
docker push ${DOCKER_REGISTRY}/hbase-master:latest
docker push ${DOCKER_REGISTRY}/hbase-region:$HBASE_VERSION
docker push ${DOCKER_REGISTRY}/hbase-region:latest

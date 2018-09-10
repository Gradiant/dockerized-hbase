#!/bin/bash

VERSION=2.0.1

docker build --build-arg VERSION=$VERSION -t gradiant/hbase-base:$VERSION hbase-base
docker build --build-arg VERSION=$VERSION -t gradiant/hbase-master:$VERSION hbase-master
docker build --build-arg VERSION=$VERSION -t gradiant/hbase-region:$VERSION hbase-region

docker tag gradiant/hbase-base:$VERSION gradiant/hbase-base:latest
docker tag gradiant/hbase-master:$VERSION gradiant/hbase-master:latest
docker tag gradiant/hbase-region:$VERSION gradiant/hbase-region:latest

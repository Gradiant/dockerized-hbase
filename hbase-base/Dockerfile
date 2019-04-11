FROM gradiant/hadoop-base:2.7.7 as hadoop

FROM openjdk:8u171-jre-alpine3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
ARG VERSION=2.0.1
ENV HBASE_VERSION=$VERSION

RUN apk add --no-cache bash perl jruby curl && mkdir /opt && \
wget -qO- http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz | tar xvz -C /opt && \
ln -s /opt/hbase-$HBASE_VERSION /opt/hbase && \
ln -s /opt/hbase-$HBASE_VERSION/conf /etc/hbase  && \
mkdir /opt/hbase-$HBASE_VERSION/logs

ENV HBASE_PREFIX=/opt/hbase-$HBASE_VERSION
ENV HBASE_CONF_DIR=/etc/hbase
ENV HBASE_CONF_hbase_cluster_distributed=true
ENV PATH $HBASE_PREFIX/bin/:$PATH

# Add hadoop native libraries for alpine
COPY --from=hadoop /opt/hadoop/lib/native/* /lib/



COPY entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]


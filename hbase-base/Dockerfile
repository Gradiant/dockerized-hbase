FROM quay.io/kaszpir/dockerized-hadoop:3.1.3 AS hadoop

FROM openjdk:8-jre-slim
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
ARG VERSION=2.1.10
ENV HBASE_VERSION=$VERSION
# notice to set valid HADOOP_VERSION as stated in base container
ENV HADOOP_VERSION=3.1.3

# buster uses jruby wich requires openjdk-11, so we add stretch and instal jruby from it
# need to add /usr/share/man/man1 dit to avoid issues during install
RUN echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list && \
    apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install --no-install-recommends -y \
      bash \
      perl \
      curl \
      wget \
      default-jre=2:1.8-58+deb9u1 \
      default-jre-headless=2:1.8-58+deb9u1 \
      jruby=1.7.26-1+deb9u1 \
    && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt && \
    wget -qO- "http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz" | tar xvz -C /opt && \
    ln -s "/opt/hbase-$HBASE_VERSION" /opt/hbase && \
    ln -s "/opt/hbase-$HBASE_VERSION/conf" /etc/hbase  && \
    mkdir -p "/opt/hbase-$HBASE_VERSION/logs"

ENV HBASE_PREFIX=/opt/hbase-$HBASE_VERSION
ENV HBASE_CONF_DIR=/etc/hbase
ENV HBASE_CONF_hbase_cluster_distributed=true
ENV PATH $HBASE_PREFIX/bin/:$PATH

# Add hadoop native libraries
# notice that COPY --from does not follow symlinks
COPY --from=hadoop /opt/hadoop-$HADOOP_VERSION/lib/native/* /lib/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


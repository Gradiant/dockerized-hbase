ARG HADOOP_IMAGE=quay.io/kaszpir/hadoop-base:3.1.3
FROM $HADOOP_IMAGE AS hadoop

FROM openjdk:8-jre-slim
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
ARG version=2.2.4
ENV HBASE_VERSION=$version
# notice to set valid HADOOP_VERSION as stated in base container
ENV HADOOP_VERSION=3.1.3 \
    HADOOP_USER_NAME=hdfs \
    USER=hbase

# buster uses jruby wich requires openjdk-11, so we add stretch and instal jruby from it
# need to add /usr/share/man/man1 dit to avoid issues during install
RUN echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      bash \
      curl \
      default-jre-headless=2:1.8-58+deb9u1 \
      default-jre=2:1.8-58+deb9u1 \
      dnsutils \
      jruby=1.7.26-1+deb9u1 \
      net-tools \
      perl \
      procps \
      psmisc \
      sed \
      wget \
    && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt && \
    wget -qO- "http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz" | tar xvz -C /opt && \
    ln -s "/opt/hbase-$HBASE_VERSION" /opt/hbase && \
    ln -s "/opt/hbase-$HBASE_VERSION/conf" /etc/hbase  && \
    groupadd -g 114 -r hadoop && \
    useradd --comment "HBase" -u 202 --shell /bin/bash -M -r --groups hadoop --home /var/lib/hbase/hbase hbase && \
    mkdir -p "/opt/hbase-$HBASE_VERSION/logs" && \
    chown -LR hbase:hadoop "/opt/hbase/" && \
    find / -name "java.security" 2>/dev/null | xargs -n1 sed -i 's/.*networkaddress.cache.ttl.*/networkaddress.cache.ttl=30/g'


ENV HBASE_PREFIX=/opt/hbase-$HBASE_VERSION
ENV HBASE_CONF_DIR=/etc/hbase
ENV HBASE_CONF_hbase_cluster_distributed=true
ENV PATH $HBASE_PREFIX/bin/:$PATH
USER hbase
WORKDIR /opt/hbase/

# Add hadoop native libraries
# notice that COPY --from does not follow symlinks
COPY --from=hadoop /opt/hadoop-$HADOOP_VERSION/lib/native/* /lib/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


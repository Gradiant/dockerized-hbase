ARG VERSION=2.1.10
ARG HBASE_IMAGE=gradiant/hbase-base:$VERSION
FROM $HBASE_IMAGE

LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"

COPY run.sh /run.sh

EXPOSE 16020 16030

CMD ["/run.sh"]

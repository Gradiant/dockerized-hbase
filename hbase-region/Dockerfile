ARG VERSION=2.0.1
FROM gradiant/hbase-base:$VERSION

LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"

COPY run.sh /run.sh

EXPOSE 16020 16030

CMD ["/run.sh"]
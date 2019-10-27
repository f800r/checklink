FROM ubuntu:18.04
MAINTAINER F800R

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.description="checklink utility running with ubuntu" \
      org.label-schema.name="checklink" \
      org.label-schema.schema-version="1.0.0-rc1" \
      org.label-schema.usage="https://github.com/f800r/checklink/blob/master/README.md" \
      org.label-schema.vcs-url="https://github.com/f800r/checklink" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="f800r" \
      org.label-schema.version="latest"
      
RUN apt-get update \
  && apt-get install -y \
      cpanminus \
      make \
      git \
      build-essential \
      libssl-dev \
      libcrypt-ssleay-perl

RUN set -x \
  && cpanm LWP::Protocol::https \
  && mkdir -p /usr/src \
  && cd /usr/src \
  && git clone https://github.com/w3c/link-checker.git \
  && cd /usr/src/link-checker \
  && cpanm --installdeps . \
  && perl Makefile.PL \
  && make \
  && make test \
  && make install 

ENTRYPOINT ["/usr/local/bin/checklink"]
CMD ["-h"]

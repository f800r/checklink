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
      zlib1g-dev \
      libssl-dev \
      libcrypt-ssleay-perl \
      ca-certificates

RUN set -x \
  && cpanm --force Net::SSLeay::Handle \
  && cpanm IO::Socket::SSL \
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

COPY ca-custom.pem /ca-custom.pem
RUN cat /ca-custom.pem >>/etc/ssl/certs/ca-certificates.crt
ENV PERL_LWP_SSL_CA_FILE /etc/ssl/certs/ca-certificates.crt
ENTRYPOINT ["/usr/local/bin/checklink"]
CMD ["-h"]

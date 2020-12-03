FROM debian:stretch

# git tag from https://github.com/stellar/stellar-core
ARG STELLAR_CORE_VERSION="v15.1.0"
ARG STELLAR_CORE_BUILD_DEPS="git build-essential pkg-config autoconf automake libtool bison flex libpq-dev wget pandoc"
ARG STELLAR_CORE_DEPS="curl jq libpq5"
ARG CONFD_VERSION="0.16.0"

LABEL maintainer="mat@stellar.org"

# install stellar core and confd
ADD install.sh /
RUN /install.sh

EXPOSE 11625
EXPOSE 11626

VOLUME /data
VOLUME /postgresql-unix-sockets
VOLUME /heka

ADD docker/install /
RUN /install

ADD docker/heka /heka
ADD docker/confd /etc/confd
ADD docker/utils /utils
ADD docker/start /

CMD ["/start"]
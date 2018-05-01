FROM ubuntu:16.04

#RUN apt-get update \
#    && apt-get -qq --no-install-recommends install \
#        libmicrohttpd10 \
#        libssl1.0.0 \
#    && rm -r /var/lib/apt/lists/*

ENV XMR_STAK_VERSION 2.4.3
ENV XMR_STAK_CMAKE_FLAGS -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF

RUN apt-get update \
    && set -x \
    && buildDeps=' \
        build-essential \
        ca-certificates \
        git \
        libhwloc-dev \
        cmake \
        curl \
        g++ \
        libmicrohttpd-dev \
        libssl-dev \
        make \
    ' \
#    && apt-get -qq update \
    && apt-get install  -qq --no-install-recommends -y $buildDeps \
#    && rm -rf /var/lib/apt/lists/* \
    \
    && mkdir -p /usr/local/src/xmr-stak/build \
    && cd /usr/local/src/xmr-stak/ \
#    && curl -sL https://github.com/fireice-uk/xmr-stak/archive/$XMR_STAK_VERSION.tar.gz | tar -xz --strip-components=1 \
    && curl -sL https://github.com/fireice-uk/xmr-stak/archive/2.4.3.tar.gz | tar -xz --strip-components=1 \
    && sed -i 's/= 2.0*/= 0.0/' xmrstak/donate-level.hpp \
    && cd build \
    && cmake ${XMR_STAK_CMAKE_FLAGS}  .. \
    && make -j$(nproc) \
    && cp bin/xmr-stak /usr/local/bin/ \
    && sed -r \
        -e 's/^("pool_address" : ).*,/\1"pool.supportxmr.com:7777",/' \
        -e 's/^("wallet_address" : ).*,/\1"47vHbK7gXWfWgaDuvpwGZzCratKixPtYhYmtLHA2QZv3HFFVVNbExunVNJh3CeT8Xa22MiMbjBRj83grCmTS6wyo4EaSSv4",/' \
        -e 's/^("pool_password" : ).*,/\1"docker-xmr-stak:x",/' \
        ../config.txt > /usr/local/bin/config.txt \
    \
    && rm -r /usr/local/src/xmr-stak \
    && apt-get purge -y -qq $buildDeps \
    && apt-get clean -qq

ENTRYPOINT ["xmr-stak"]
CMD ["/usr/local/bin/config.txt"]
#CMD ["/usr/local/bin/xmr-stak"]

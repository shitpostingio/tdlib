# Pull from debian 10 buster
FROM debian:buster

# Install dependencies
RUN apt update && apt install -y -qq \
    make \
    git \
    zlib1g-dev \
    libssl-dev \
    gperf \
    cmake \
    g++

# Begin compilation
RUN git clone https://github.com/tdlib/td.git; \
    cd td; \
    git checkout v1.7.0; \
    rm -rf build; \
    mkdir build; \
    cd build; \
    export CXXFLAGS=""; \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
    cmake --build . --target prepare_cross_compiling; \
    cmake --build . --target install; \
    cd ..; \
    ls -l /usr/local;

# Let's clean
RUN apt-get remove -y \
    gperf \
    cmake; \
    apt-get autoremove -y; \
    apt-get autoclean

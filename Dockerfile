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
    git checkout 3ff9723722a88022e4698a5562c2f8901dec63fa; \
    rm -rf build; \
    mkdir build; \
    cd build; \
    export CXXFLAGS=""; \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
    cmake --build . --target prepare_cross_compiling; \
    cmake --build . --target install; \

# Let's clean
RUN apt-get remove -y \
    gperf \
    cmake; \
    apt-get autoremove -y; \
    apt-get autoclean

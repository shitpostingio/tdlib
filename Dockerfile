# Pull from debian 10 buster
FROM debian:buster

# Dependencies
RUN apt update && apt install -y -qq \
    make \
    git \
    zlib1g-dev \
    libssl-dev \
    gperf \
    cmake \
    clang \
    libc++-dev \
    libc++abi-dev

# Begin compilation
RUN git clone https://github.com/tdlib/td.git; \
    cd td; \
    rm -rf build; \
    mkdir build; \
    cd build; \
    export CXXFLAGS="-stdlib=libc++"; \
    CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
    cmake --build . --target install;


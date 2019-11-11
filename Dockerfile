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
    g++

# Begin compilation
RUN git clone https://github.com/tdlib/td.git; \
    cd td; \
    rm -rf build; \
    mkdir build; \
    cd build; \
    export CXXFLAGS=""; \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
    cmake --build . --target prepare_cross_compiling; \
    php SplitSource.php; \
    cd build; \
    cmake --build . --target install; \
    cd ..; \
    php SplitSource.php --undo; \
    cd ..; \
    ls -l /usr/local;


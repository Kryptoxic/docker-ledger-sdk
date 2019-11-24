FROM ubuntu:19.10
LABEL maintainer1="Luke Childs <lukechilds123@gmail.com>"
LABEL maintainer2="Ryan Chew  <ryanchew96@gmail.com>"

VOLUME ["/code"]
WORKDIR /code

ENV BOLOS_ENV /opt/bolos-env
ENV BOLOS_SDK /opt/bolos-sdk

RUN apt-get update

RUN apt-get install -y --no-install-recommends libc6-dev-i386 python python3 python-pil curl ca-certificates bzip2 xz-utils git make

RUN echo "Create install directories" && \
  mkdir ${BOLOS_ENV} ${BOLOS_SDK}

RUN echo "Install ledgerblue and btchip" && \
  apt install -y python-pip python3-pip && \
  pip install setuptools && \
  pip install ledgerblue btchip-python && \
  pip3 install ledgerblue btchip-python

RUN echo "Install custom gcc"
RUN curl -L https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 --output /tmp/gcc.tar.bz2
RUN tar -xvf /tmp/gcc.tar.bz2 -C ${BOLOS_ENV}
RUN mv ${BOLOS_ENV}/gcc-arm-none-eabi-9-2019-q4-major ${BOLOS_ENV}/gcc-arm-none-eabi-5_3-2016q1
RUN rm /tmp/gcc.tar.bz2

RUN echo "Install custom clang"
RUN curl -L https://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-pc-linux-gnu.tar.xz --output /tmp/clang.tar.xz
RUN tar -xvf /tmp/clang.tar.xz -C ${BOLOS_ENV}
RUN mv ${BOLOS_ENV}/clang+llvm-9.0.0-x86_64-pc-linux-gnu ${BOLOS_ENV}/clang-arm-fropi
RUN rm /tmp/clang.tar.xz

RUN echo "Install libz3"
RUN apt install libz3-4 libz3-dev -y

RUN echo "Symlink libz3"
RUN ln -s /usr/lib/x86_64-linux-gnu/libz3.so.4 /usr/lib/x86_64-linux-gnu/libz3.so.4.8

RUN echo "Install Ledger Nano S SDK"
RUN git clone https://github.com/LedgerHQ/nanos-secure-sdk.git ${BOLOS_SDK}
RUN cd ${BOLOS_SDK} && git checkout tags/nanos-160

COPY ./bin/init /usr/local/bin/init

ENTRYPOINT ["init"]

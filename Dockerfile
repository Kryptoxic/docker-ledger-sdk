FROM ubuntu:20.04
LABEL maintainer1="Luke Childs <lukechilds123@gmail.com>"
LABEL maintainer2="Ryan Chew  <ryanchew96@gmail.com>"

VOLUME ["/code"]
WORKDIR /code

ENV BOLOS_SDK /opt/bolos-sdk

RUN echo "Update base image and install dependencies" && \
  apt update && \
  apt upgrade -y && \
  apt install -y build-essential git make clang gcc-arm-none-eabi gcc-multilib g++-multilib

RUN echo "Create SDK directory" && \
  mkdir ${BOLOS_SDK}

RUN echo "Install Ledger Nano S SDK" && \
  git clone https://github.com/LedgerHQ/nanos-secure-sdk.git ${BOLOS_SDK} && \
  cd ${BOLOS_SDK} && git checkout tags/nanos-160

RUN echo "Install python modules" && \
  apt install python3-pip libudev-dev libusb-1.0-0-dev -y && \
  pip3 install ledgerblue btchip-python

COPY ./bin/init /usr/local/bin/init

ENTRYPOINT ["init"]
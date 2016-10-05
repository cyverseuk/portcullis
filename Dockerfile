from ubuntu:16.04

run echo 'deb http://archive.ubuntu.com/ubuntu/ xenial-security multiverse' >> /etc/apt/sources.list
run echo 'deb-src http://archive.ubuntu.com/ubuntu/ xenial-security multiverse' >> /etc/apt/sources.list

run apt update
run apt install -y libboost-all-dev python3-dev samtools autoconf git g++ zlib1g-dev libtool python3-sklearn python3-scipy python3-matplotlib python3-numpy python-pip
run pip install sphinx

workdir /root

run git clone https://github.com/maplesond/portcullis.git

workdir /root/portcullis

env PYTHON=/usr/bin/python3

run ./autogen.sh

run ./configure

run make

run make install

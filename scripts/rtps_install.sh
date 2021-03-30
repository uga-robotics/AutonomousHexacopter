#!/usr/bin/env bash

mkdir -p /home/ubuntu/usr/local
git clone --recursive https://github.com/eProsima/Fast-DDS.git -b v2.0.0 ~/FastDDS-2.0.0
cd ~/FastDDS-2.0.0
mkdir build && cd build
cmake -DTHIRDPARTY=ON -DSECURITY=ON -DCMAKE_INSTALL_PREFIX=/home/ubuntu/usr/local ..
make -j$(nproc --all)
sudo make install
git clone --recursive https://github.com/eProsima/Fast-DDS-Gen.git -b v1.0.4 ~/Fast-RTPS-Gen \
    && cd ~/Fast-RTPS-Gen \
    && ./gradlew assemble \
    && sudo ./gradlew -p /home/ubuntu/usr/local install
export FASTRTPSGEN_DIR=/home/ubuntu/usr/local
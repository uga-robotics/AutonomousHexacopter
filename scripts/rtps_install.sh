#!/usr/bin/env bash

sudo apt install -y cmake g++ python3-pip wget git libasio-dev libtinyxml2-dev libssl-dev openjdk-11-jre
sudo pip3 install -U colcon-common-extensions vcstool
sudo mkdir ~/Fast-DDS
sudo cd ~/Fast-DDS
sudo wget https://raw.githubusercontent.com/eProsima/Fast-DDS/master/fastrtps.repos
sudo mkdir src
sudo vcs import src < fastrtps.repos
sudo colcon build
sudo cd ~
sudo git clone --recursive https://github.com/eProsima/Fast-DDS-Gen.git
sudo cd ~/Fast-DDS-Gen
sudo ./gradlew assemble

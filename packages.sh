#!/bin/bash
sudo apt update
sudo apt-get -y install \
build-essential \
python3-pip \
mc \
tig
wget https://github.com/tomnomnom/gron/releases/gron-linux-amd64-0.6.0.tgz
sudo pip3 install awscli

#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

sudo apt-get remove docker docker-engine docker.io -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt-get install docker-ce --force-yes -y
sudo usermod -aG docker vagrant
sudo service docker start
docker version






#!/bin/sh

sudo apt-get update
#sudo apt-get -y upgrade

sudo apt-get install -y docker.io
sudo apt-get install -y docker-compose

sudo groupadd docker
sudo usermod -aG docker ubuntu

sudo systemctl enable docker

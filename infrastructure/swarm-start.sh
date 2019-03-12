#!/bin/bash

USER=$1
PASSWORD=$2
NODE=$3
manager_ip=`hostname -I | cut -d' ' -f1`

echo '### Initializing swarm'
docker swarm init --advertise-addr=$manager_ip

manager_token=$(docker swarm join-token manager -q)
worker_token=$(docker swarm join-token worker -q)

join_command="docker swarm join --token $worker_token $manager_ip:2377"

echo '### Adding worker node'
#note: the accept-new option is only available for Ubuntu 18.04
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=accept-new  $USER@$NODE $join_command

echo '### Creating service'
docker service create --replicas 3 --name web nginx

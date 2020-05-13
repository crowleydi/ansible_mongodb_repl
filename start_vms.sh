#!/bin/sh

# Create mynet docker network if it does not already exist
docker network inspect mynet >/dev/null 2>&1 || docker network create --subnet 172.18.0.0/24 mynet

# start the "master"
docker run --detach --rm --hostname mongo0 --name mongo0 --network mynet --ip 172.18.0.3 rastasheep/ubuntu-sshd
# start "slaves"
docker run --detach --rm --hostname mongo1 --name mongo1 --network mynet --ip 172.18.0.4 rastasheep/ubuntu-sshd
docker run --detach --rm --hostname mongo2 --name mongo2 --network mynet --ip 172.18.0.5 rastasheep/ubuntu-sshd

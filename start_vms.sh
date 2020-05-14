#!/bin/sh

# Create mynet docker network if it does not already exist
docker network inspect mynet >/dev/null 2>&1 || docker network create --subnet 172.18.0.0/24 mynet
# Build Dockerfile, adds pub/priv keys generated using ssh-keygen
sudo docker build -t mysshimage --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .

# start the "master"
docker run --detach --rm --hostname mongo0 --name mongo0 --network mynet --ip 172.18.0.3 rastasheep/ubuntu-sshd
# start "slaves"
docker run --detach --rm --hostname mongo1 --name mongo1 --network mynet --ip 172.18.0.4 rastasheep/ubuntu-sshd
docker run --detach --rm --hostname mongo2 --name mongo2 --network mynet --ip 172.18.0.5 rastasheep/ubuntu-sshd

#
# copy our ssh key to the hosts so we can login automatically
ssh-copy-id root@mongo0
ssh-copy-id root@mongo1
ssh-copy-id root@mongo2

echo
echo
echo "If you haven't already, please add the following lines to your /etc/hosts file: "
echo
echo 172.18.0.3 mongo0
echo 172.18.0.4 mongo1
echo 172.18.0.5 mongo2
echo 
echo 

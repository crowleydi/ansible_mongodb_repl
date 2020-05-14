#!/bin/sh

# Create mynet docker network if it does not already exist

echo
echo "Creating docker network"
echo
docker network inspect mynet >/dev/null 2>&1 || docker network create --subnet 172.18.0.0/24 mynet

# Build Dockerfile, adds pub/priv keys generated using ssh-keygen
#sudo docker build -t mysshimage --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .

# start primary/master node
echo
echo "Starting primary node mongo0"
echo
docker run --detach --rm --hostname mongo0 --name mongo0 --network mynet --ip 172.18.0.3 rastasheep/ubuntu-sshd
# start secondary nodes
echo
echo "Starting secondary nodes mongo1, mongo2"
echo
docker run --detach --rm --hostname mongo1 --name mongo1 --network mynet --ip 172.18.0.4 rastasheep/ubuntu-sshd
docker run --detach --rm --hostname mongo2 --name mongo2 --network mynet --ip 172.18.0.5 rastasheep/ubuntu-sshd

#
# update /etc/hosts
echo
echo Updating /etc/hosts to resolve node names
echo
grep mongo0 /etc/hosts > /dev/null 2>& 1 || sudo tee -a /etc/hosts <<EOF
172.18.0.3 mongo0
172.18.0.4 mongo1
172.18.0.5 mongo2
EOF

#
# copy our ssh key to the hosts so we can login automatically

echo 
echo Copying ssh keys to nodes. The default root password is \"root\"
echo and you will have to enter this password for each node.
echo
ssh-copy-id root@mongo0
ssh-copy-id root@mongo1
ssh-copy-id root@mongo2

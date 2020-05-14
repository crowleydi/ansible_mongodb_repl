# ECE 530 Cloud Computing
## Homework #4

David Crowley and Michael Truong

This repository contains the scripts to deploy and configure three Docker containers as a MongoDB replica set.

Before running the playbook, it is important to have generated an ssh authentication key-pair for the user (i.e. ssh-keygen). Also, note that it is important to be able to run docker without root priveleges. For guidance on how to add a connected user to the docker group refer to this [post](https://askubuntu.com/a/477554/1061536).

To start the three containers for the replica set, use:

```
./start_vms.sh
```

When copying ssh keys to the nodes, you will be prompted to enter a password for each node. The default password is **root**.

To run the playbook and create the replica set, use:

```
./run_playbook.sh
```

Finally, to shutdown all of the containers and remove the docker network, use:

```
./stop_vms.sh
```

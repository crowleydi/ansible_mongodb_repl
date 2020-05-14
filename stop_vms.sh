#!/bin/bash

echo
echo "Shutting down and removing the mongo containers/VMs"
echo
docker stop mongo0
docker stop mongo1
docker stop mongo2
echo
echo "Removing the docker network"
echo
docker network rm mynet

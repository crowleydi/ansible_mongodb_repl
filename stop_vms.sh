#!/bin/bash
docker stop mongo0
docker stop mongo1
docker stop mongo2
docker network rm mynet

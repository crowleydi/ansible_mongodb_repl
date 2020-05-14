#!/bin/sh
apt remove --purge mongodb
rm -fr /var/lib/mongodb
rm -f /root/rs_initiate.sh
rm -f /root/reset.sh
rm -f /root/restart.sh
rm -f /root/rs_register.sh
mkdir -p /var/lib/mongodb
chown mongodb:mongodb /var/lib/mongodb

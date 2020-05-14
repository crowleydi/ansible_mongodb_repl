#!/bin/sh

#
# script to re-start mongodb because the
# installed init.d script doesn't work
#
kill `ps ax | grep -v grep | grep mongod | awk '{print $1}'`
/etc/init.d/mongodb start

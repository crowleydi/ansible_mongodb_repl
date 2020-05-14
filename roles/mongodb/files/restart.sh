#!/bin/sh

#
# script to re-start mongodb because the
# installed init.d script doesn't work
#

pid=`ps ax | grep -v grep | grep mongod | awk '{print $1}'`

if [ -n "$pid" ]; then
        kill $pid
        while [ -e /proc/$pid ]; do
                sleep 1
        done
fi

/etc/init.d/mongodb start

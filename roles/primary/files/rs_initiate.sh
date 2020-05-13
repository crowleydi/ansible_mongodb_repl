#!/bin/sh
mongo <<EOF
rs.initiate();
EOF

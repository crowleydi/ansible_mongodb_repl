#!/bin/sh
MASTER={{ groups["primary"][0] }}
HOST=`hostname`
mongo --host $MASTER <<EOF
rs.add({"host": "$HOST", "priority": 0, "votes": 0});
EOF
sleep 5
mongo --host $MASTER <<EOF
var cfg=rs.conf();
var n;
for (n = 0; n < cfg.members.length; n++) {
	if (cfg.members[n].host == "$HOST:27017") {
		cfg.members[n].priority=1;
		cfg.members[n].votes=1;
	}
}
rs.reconfig(cfg);
EOF
sleep 2

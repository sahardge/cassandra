#!/usr/bin/env bash

IP=`/usr/bin/etcdctl --peers 172.17.42.1:4001 get /cassandraSeed/node1`



echo Bringing up Cassandra cluster seed $IP 

# Setup Cassandra

CONFIG=/etc/cassandra

sed -i -e "s/^listen_address.*/listen_address: $IP/" $CONFIG/cassandra.yaml
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CONFIG/cassandra.yaml
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$IP\"/" $CONFIG/cassandra.yaml
sed -i -e "s/# JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=<public name>\"/ JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=$IP\"/" $CONFIG/cassandra-env.sh

cassandra -f

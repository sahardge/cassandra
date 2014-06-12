#!/usr/bin/env bash

IP=`hostname --ip-address`

/bin/etcdctl --peers 10.1.42.1 set /seed $IP

echo Bringing up Cassandra cluster seed $IP 

# Setup Cassandra

CONFIG=/etc/cassandra

sed -i -e "s/^listen_address.*/listen_address: $IP/" $CONFIG/cassandra.yaml
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CONFIG/cassandra.yaml
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$IP\"/" $CONFIG/cassandra.yaml
sed -i -e "s/# JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=<public name>\"/ JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=$IP\"/" $CONFIG/cassandra-env.sh

cassandra -f

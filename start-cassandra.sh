IP=ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

cat /etc/cassandra/cassandra.yaml.orig | sed -e "112,197 s|/var/lib|/mountedvol|g" | sed -e "329 s/localhost/""$IP""/" | sed -e "365 s/localhost/""$IP""/" | sed -e "238 s/127.0.0.1/""$IP""/" > /etc/cassandra/cassandra.yaml
cassandra -f


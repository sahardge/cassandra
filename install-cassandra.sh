#!/bin/bash

IP=`hostname --ip-address`

# Cassandra setup first
if [ ! -e /usr/sbin/cassandra ]; then
echo "Installing Cassandra 1.2 branch..."
  sh -c 'echo "deb http://www.apache.org/dist/cassandra/debian 12x main" > /etc/apt/sources.list.d/cassandra.list'
  sh -c 'echo "deb-src http://www.apache.org/dist/cassandra/debian 12x main" >> /etc/apt/sources.list.d/cassandra.list'
  gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
  gpg --export --armor F758CE318D77295D | apt-key add -
  gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
  gpg --export --armor 2B5C1B00 | apt-key add -
  apt-get update
  apt-get -y install cassandra
  service cassandra stop # kill the default instance
  echo "Cassandra has been installed."
  echo "Making appropriate configuration changes."
  mv /etc/cassandra/cassandra.yaml /etc/cassandra/cassandra.yaml.orig 
  cat /etc/cassandra/cassandra.yaml.orig | sed -e "112,197 s|/var/lib|/mountedvol|g" | sed -e "329 s/localhost/""$IP""/" | sed -e "365 s/localhost/""$IP""/" | sed -e "238 s/127.0.0.1/""$IP""/" > /etc/cassandra/cassandra.yaml
  cp start-cass.sh /usr/sbin
  cp ipof.sh /usr/sbin
  
fi

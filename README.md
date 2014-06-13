cassandra
=========
How to use:

This repo is designed to set up a Cassandra (1.2) cluster in a virtual CoreOS environment using Docker and etcd.

How does it work?
==========

Making sure you have at least a 3 node cluster, submit and start the CassandraSeed.Service file in fleet. This will create a docker container with a cassandra instance assuming the role of a seed, and will then push this information to etcd (details in start-seed.sh). After that, submit and start, with fleet, a cassnode@*.service file***. This will set up a container with a cassandra node configured to grab from etcd the IP of the cassandra cluster seed, and will then join the cluster with that information. 

You can either pull this repo and build the dockerfile locally, but the service files will pull the repo on each run regardless. I will try to keep both sources the same so you don't have to keep pulling different repos with minor differences


***Make sure that you copy and rename the cassnode@*.service file to whichever node number you need, presumably starting at cassnode@1.service. 

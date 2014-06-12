#!/bin/bash

wget -q https://github.com/coreos/etcd/releases/download/v0.4.0/etcd-v0.4.0-darwin-amd64.zip && unzip etcd-v0.4.0-darwin-amd64.zip -d /tmp/etcd
mv /tmp/etcd/etcd-v0.4.0-darwin-amd64/etcd /usr/bin && mv /tmp/etcd/etcd-v0.4.0-darwin-amd64/etcdctl /usr/bin

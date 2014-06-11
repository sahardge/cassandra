#!/bin/bash

SEEDS=(/usr/bin/docker inspect --format '{{ .NetworkSettings.IPAddress }}' seed)

/bin/etcdctl set /seed $SEEDS

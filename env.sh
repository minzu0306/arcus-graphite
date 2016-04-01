#!/bin/bash

# Path to your collectd installation.
export GRAPHITE_COLLECTD_HOME=/home/arcus_graphite/arcus_collectd

# ZooKeeper hosts
#export GRAPHITE_ZOOKEEPER_HOSTS="10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181"

# Hubble Orbiter Port
# - Orbiter watches Arcus directories in ZooKeeper.
# - And serves informations for every cache cluster in the ZooKeeper.
export GRAPHITE_ORBITER_PORT=3001

#!/bin/bash
#
# Run processes for the cluster
# running on a single dev machine as a demo...

mkdir a0 a1 a2
mkdir b0 b1 b2
mkdir c0 c1 c2
mkdir d0 d1 d2
mkdir g0 g1 g2

# config servers
mongod --configsvr --port 26050 --dbpath g0 --logpath log.g0 --logappend --fork
mongod --configsvr --port 26051 --dbpath g1 --logpath log.g1 --logappend --fork
mongod --configsvr --port 26052 --dbpath g2 --logpath log.g2 --logappend --fork

# "shard servers" (mongod data servers)
# note: don't use smallfiles nor such a small oplogSize in production;
#       these are here because we're running many on one machine
mongod --shardsvr --replSet a --port 27000 --dbpath a0 --logpath log.a0 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet a --port 27001 --dbpath a1 --logpath log.a1 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet a --port 27002 --dbpath a2 --logpath log.a2 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet b --port 27100 --dbpath b0 --logpath log.b0 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet b --port 27101 --dbpath b1 --logpath log.b1 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet b --port 27102 --dbpath b2 --logpath log.b2 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet c --port 27200 --dbpath c0 --logpath log.c0 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet c --port 27201 --dbpath c1 --logpath log.c1 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet c --port 27202 --dbpath c2 --logpath log.c2 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet d --port 27300 --dbpath d0 --logpath log.d0 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet d --port 27301 --dbpath d1 --logpath log.d1 --logappend --smallfiles --oplogSize 50 --fork
mongod --shardsvr --replSet d --port 27302 --dbpath d2 --logpath log.d2 --logappend --smallfiles --oplogSize 50 --fork

# mongos processes
# note: best practice is to use logical names (cname) for the servers
#       never use local host
#       don't use raw IP addresses
mongos --port 27017 --configdb `hostname`:26050,`hostname`:26051,`hostname`:26052 --logpath log.mongos0 --logappend --fork
mongos --port 26061 --configdb `hostname`:26050,`hostname`:26051,`hostname`:26052 --logpath log.mongos1 --logappend --fork
mongos --port 26062 --configdb `hostname`:26050,`hostname`:26051,`hostname`:26052 --logpath log.mongos2 --logappend --fork
mongos --port 26063 --configdb `hostname`:26050,`hostname`:26051,`hostname`:26052 --logpath log.mongos3 --logappend --fork

echo
ps -e | grep mongo

echo
tail -n 1 log.g0 
tail -n 1 log.g1 
tail -n 1 log.g2
echo
tail -n 1 log.a0 
tail -n 1 log.a1 
tail -n 1 log.a2
tail -n 1 log.b0 
tail -n 1 log.b1 
tail -n 1 log.b2
tail -n 1 log.c0 
tail -n 1 log.c1 
tail -n 1 log.c2
tail -n 1 log.d0 
tail -n 1 log.d1 
tail -n 1 log.d2
echo
tail -n 1 log.mongos0 
tail -n 1 log.mongos1 
tail -n 1 log.mongos2 
tail -n 1 log.mongos3
echo
echo "hostname is " `hostname`

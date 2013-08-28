shard-demo
==========

A small demo to build out a four shard mongodb cluster on a single dev box. Warning: Obviously this is for experimental purposes only. This configuration would be an extremely poor choice for production.

Includes scripts to build out the following:
- 4 shards
- 3 member replica set per shard
- 3 config servers
- 4 mongos processes 

Also includes a simple data generation script.

Note: the local hostname is hard coded in the 

shard-demo
==========

A small demo to build out a four shard mongodb cluster on a single dev box. Warning: Obviously this is for experimental purposes only. This configuration would be an extremely poor choice for production.

Includes scripts to build out the following:
- 4 shards
- 3 member replica set per shard
- 3 config servers
- 4 mongos processes 

Also includes a simple data generation script.

Note: the local hostname is hard coded in our\_add\_shard.js. Be sure to edit it appropriately. It's probably not a good idea to use localhost, so go with your correct hostname.

To get things running, do the following:

    ./start_set.sh
    mongo --shell our\_add\_shard.js

Then, within the mongo shell run

    ourAddShard(setname, portnumber)

once for each shard started in start_set.sh. Be sure to use the lowest port number for each replset, e.g.

    ourAddShard("a", 27000)

Then, exit mongo and create some sharded collections with

    mongo shard_collections.js

Now the environment is set up. If you want to play with things, start generating data with 

    mongo gen_data.js

and monitor in another shell with

    mongostat --discover

Also try tailing one or more of the log files in additional shell windows with

    tail -f log.a0

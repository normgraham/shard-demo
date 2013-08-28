var demo = db.getSiblingDB('demo');
demo.dropDatabase();
sh.enableSharding('demo');
sh.shardCollection('demo.users', {"_id": "hashed" });
sh.shardCollection('demo.notifications', {"_id": "hashed" });
demo.users.ensureIndex({'b.p':1});
//demo.runCommand( {collMod: "users", usePowerOf2Sizes : true })
//demo.runCommand( {collMod: "notifications", usePowerOf2Sizes : true })


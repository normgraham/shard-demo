db = db.getSisterDB("config");

var myHost = "Veronica.local"	// or just "Veronica" if at home.

var mongosConn = db; // assume we connected to a mongos to get going

var res = null;

function check() {
	printjson(res);
	if( !res || !res.ok ) {
		throw "check(): not ok, stopping";
	}
}

function waitForSetHealthy() {
	print("waiting for repl set initiate to complete...");
	while( 1 ) {
		sleep(250);
		var res = rs.status();
		if( !res.ok )
			continue;
		var bad = false;
		for (var i = 0; i < res.members.length; i++ ) {
			var state = res.members[i].state;
			if( state != 1 && state != 2 ) // primary or secondary?
				bad = true;
		}
		if( !bad )
			break;
	} 
}

function ourAddShard(setname,port) {
	db = connect(myHost + ":" + port + "/test");
	// me isn't added to isMaster until after rs.initiate()
	// print(db.isMaster().me);
	res = rs.initiate(
		{
			"_id" : setname,
			"members" : [
				{ _id: 0, host: myHost + ":" + port },
				{ _id: 1, host: myHost + ":" + (port+1) },
				{ _id: 2, host: myHost + ":" + (port+2) }
			]
		}
	);
	check();
	waitForSetHealthy();

	print("adding shard...");
	db = mongosConn;
	res = sh.addShard(setname + "/" + myHost + ":" + port);
	check();
	print("done; run sh.status()");
}

print("setup.js loaded.");
print("list of existing shards before doing anything:");
printjson( db.shards.find().toArray() );
print()
print("You can invoke:");
print("ourAddShard(setname,port)");
print()
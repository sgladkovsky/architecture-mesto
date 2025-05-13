sh.addShard( "shard1rs/mongo_shard1:27017");
sh.addShard( "shard2rs/mongo_shard2:27017");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );

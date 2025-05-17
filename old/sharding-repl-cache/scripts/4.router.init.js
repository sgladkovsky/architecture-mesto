sh.addShard( "shard1rs/mongo_shard1a:27017");
sh.addShard( "shard2rs/mongo_shard2a:27017");
sh.addShard( "shard1rs/mongo_shard1b:27017");
sh.addShard( "shard2rs/mongo_shard2b:27017");
sh.addShard( "shard1rs/mongo_shard1c:27017");
sh.addShard( "shard2rs/mongo_shard2c:27017");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );

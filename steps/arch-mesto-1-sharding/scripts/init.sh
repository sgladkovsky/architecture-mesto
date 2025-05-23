#!/bin/bash

echo "Init config_server"

docker compose exec -T configSrv mongosh --quiet <<EOF

rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);

exit();

EOF


echo "Init shard #1"

docker compose exec -T mongo_shard1 mongosh --quiet <<EOF

rs.initiate(
    {
      _id : "shard1rs",
      members: [
        { _id : 0, host : "mongo_shard1:27017" },
   //     { _id : 1, host : "mongo_shard2:27017" }
      ]
    }
);
exit();

EOF



echo "Init shard #2"

docker compose exec -T mongo_shard2 mongosh --quiet <<EOF

rs.initiate(
    {
      _id : "shard2rs",
      members: [
//        { _id : 0, host : "mongo_shard1:27017" },
        { _id : 1, host : "mongo_shard2:27017" }
      ]
    }
);
exit();

EOF

echo "Add shard to router"

docker compose exec -T mongo_router mongosh --quiet <<EOF

sh.addShard( "shard1rs/mongo_shard1:27017");
sh.addShard( "shard2rs/mongo_shard2:27017");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );

EOF


echo "Fill test data into router"
docker compose exec -T mongo_router mongosh --quiet <<EOF

console.log('Test Start')

db = db.getSiblingDB('somedb');
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i});

print("Test Complete " + db.helloDoc.countDocuments());

EOF
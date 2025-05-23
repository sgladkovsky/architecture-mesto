#!/bin/bash

echo Check Shard#1 REPLICA

echo "Check shard 1 replica A"
docker compose exec -T mongo_shard1a mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

echo "Check shard 1 replica B"
docker compose exec -T mongo_shard1b mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

echo "Check shard 1 replica C"
docker compose exec -T mongo_shard1c mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF


echo Check Shard#2 REPLICA

echo "Check shard 2 replica A"
docker compose exec -T mongo_shard2a mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
echo "Check shard 2 replica B"
docker compose exec -T mongo_shard2b mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
echo "Check shard 2 replica C"
docker compose exec -T mongo_shard2c mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

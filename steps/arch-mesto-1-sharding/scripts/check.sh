#!/bin/bash


docker compose exec -T mongo_shard1 mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T mongo_shard2 mongosh --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

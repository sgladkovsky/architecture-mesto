rs.initiate(
    {
        _id: "shard2rs",
        members: [
            {_id: 3, host: "mongo_shard2a:27017"},
            {_id: 4, host: "mongo_shard2b:27017"},
            {_id: 5, host: "mongo_shard2c:27017"}
        ]
    }
);
exit();
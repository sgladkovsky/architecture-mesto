rs.initiate(
    {
      _id : "shard2rs",
      members: [
     //   { _id : 0, host : "mongo_shard1:27017" },
        { _id : 1, host : "mongo_shard2:27017" }
      ]
    }
);
exit();
console.log('Test Start')

db = db.getSiblingDB('somedb');
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i});

print("Test Complete " + db.helloDoc.countDocuments());
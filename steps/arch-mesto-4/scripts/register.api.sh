curl "http://127.0.0.1:8500/v1/agent/service/register" -X PUT \
  -H "Content-Type: application/json" \
  -d '{
    "ID": "pymongo-api-1",
    "Name": "pymongo-api",
    "Tags": ["pymongo-api", "v1"],
    "Address": "'10.5.0.101'",
    "Port": 8080,
    "Weights": {
      "Passing": 10,
      "Warning": 1
    }
  }'

curl "http://127.0.0.1:8500/v1/agent/service/register" -X PUT \
  -H "Content-Type: application/json" \
  -d '{
    "ID": "pymongo-api-2",
    "Name": "pymongo-api",
    "Tags": ["pymongo-api", "v1"],
    "Address": "'10.5.0.102'",
    "Port": 8080,
    "Weights": {
      "Passing": 10,
      "Warning": 1
    }
  }'
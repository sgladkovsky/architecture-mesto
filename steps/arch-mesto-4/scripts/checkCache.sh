dt_start=$(date +%s%N)

curl http://192.168.88.31:8080/helloDoc/users > first_call.json

dur=$((($(date +%s%N) - $dt_start)/1000000))

echo "Time is $dur ms"

echo "~~~~~~~~~~~~~~"
echo "Repeat curl"
dt_start=$(date +%s%N)

curl http://192.168.88.31:8080/helloDoc/users > second_call.json

dur=$((($(date +%s%N) - $dt_start)/1000000))

echo "Time is $dur ms <--- less then 100ms"

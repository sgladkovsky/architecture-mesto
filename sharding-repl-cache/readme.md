Выполнить команду в терминале
Инициацилазия конфиг сервера
```shell
 docker exec -it configSrv mongosh /scripts/1.configsrv.js

```

Инициализация первой шарды
```shell
 docker exec -it mongo_shard1a mongosh /scripts/2.shard1.init.js

```

Инициализация второй шарды
```shell
 docker exec -it mongo_shard2a mongosh /scripts/3.shard2.init.js
```

Инициализация роутера
```shell
 docker exec -it mongos_router mongosh /scripts/4.router.init.js
```
и заполнение данными
```shell
 docker exec -it mongos_router mongosh /scripts/5.router.data.js
```



Запуск всего сразу
```shell
 echo 'Init config server'
 docker exec -it configSrv mongosh /scripts/1.configsrv.js
 echo 'init shard1'
 docker exec -it mongo_shard1 mongosh /scripts/2.shard1.init.js
 echo 'init shard2'
 docker exec -it mongo_shard2 mongosh /scripts/3.shard2.init.js
 echo 'init router'
 docker exec -it mongos_router mongosh /scripts/4.router.init.js
 echo 'fill data on router'
 docker exec -it mongos_router mongosh /scripts/5.router.data.js
```
!!!! Внимание запуск из pycharm происходит в обратном порядке. Запускать или последовательно или в bash 

# Выполнение работ

## Шаг 1. Создание шардинга

Создаются 2 шарды, с одним конфиг сервером и одним роутером

| Имя          | Реплика  | Порт* |
|--------------|----------|-------|
| configSrv    |          | 27017 |
| mongo_shard1 | shard1rs | 27018 |
| mongo_shard2 | shard1rs | 27019 |
| mongo_router |          | 27020 |

*Порт это прокинутый порт на докере.
Все контейнеры создаются с портом по умолчанию 27017, чтобы можно было тестировать mongosh с минимумом манипуляций

Примечания: Из сценария docker-compose удалены healthcheck и закрепление ip.

### Запуск

Запуск сборки и разворачивания контейнеров

```shell
docker compose up -d
```

Инициализация и заполнение тестовыми данными

```shell
bash ./scripts/init.sh
```

Проверка, что шарды отработали согласно задуманному

```shell
bash ./scripts/check.sh
```

Вывод укажет количество документов в каждом шарде.
Количество должно содержать не нулевое значение, а в сумме давать 1000

Также проверка работспособности приложения

```curl
curl <ip адресс докера>:8080
```

Должен быть выдан документ такого содержания

```json
{
  "mongo_topology_type": "Sharded",
  "mongo_replicaset_name": null,
  "mongo_db": "somedb",
  "read_preference": "Primary()",
  "mongo_nodes": [
    [
      "mongo_router",
      27017
    ]
  ],
  "mongo_primary_host": null,
  "mongo_secondary_hosts": [],
  "mongo_address": [
    "mongo_router",
    27017
  ],
  "mongo_is_primary": true,
  "mongo_is_mongos": true,
  "collections": {
    "helloDoc": {
      "documents_count": 1000
    }
  },
  "shards": {
    "shard1rs": "shard1rs/mongo_shard1:27017",
    "shard2rs": "shard2rs/mongo_shard2:27017"
  },
  "cache_enabled": false,
  "status": "OK"
}

```

Также можно проверить количество документов загруженных в коллекцию helloDoc

Команда
```shell
 curl http://192.168.88.31:8080/helloDoc/count
```
*192.168.88.31 - Имя сервера, где развернут докер 

Ответ
```json
{
  "status": "OK",
  "mongo_db": "somedb",
  "items_count": 1000
}
```
## Шаг2. Добавление репликации

### Конфигурация

| Имя           | Реплика  | Порт* |
|---------------|----------|-------|
| configSrv     |          | 27017 |
| mongo_shard1a | shard1rs | 27041 |
| mongo_shard1b | shard1rs | 27042 |
| mongo_shard1c | shard1rs | 27043 |
| mongo_shard2a | shard2rs | 27051 |
| mongo_shard2b | shard2rs | 27052 |
| mongo_shard2c | shard2rs | 27053 |
| mongo_router  |          | 27020 |



### Запуск

Запуск сборки и разворачивания контейнеров

```shell
docker compose up -d
```

Инициализация и заполнение тестовыми данными

```shell
bash ./scripts/init.sh
```

Проверка, что шарды отработали согласно задуманному

```shell
bash ./scripts/check.sh
```
### Проверка работоспособности

Аналогична проверке по количеству документов шага 1 + необходимо проверить что в репликах также есть записи 
их количество соответствует ReplicaSet для каждого шарда.

Обязательно по check.sh проверить, что количество документов для shard1 и shard2 совпадает во всех репликах.

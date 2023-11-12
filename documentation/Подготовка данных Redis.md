## Подготовка данных Redis

#### Проерка, что Redis работает

```sh
#Linux command line
curl -X POST https://redis-data-service.sprint9.tgcloudenv.ru/test_redis \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "redis":{
        "host": "c-c9qja0hmkcut98r1da5u.rw.mdb.yandexcloud.net",
        "port": 6380,
        "password": "********"
    }
}
EOF

#Windows CMD
curl -X POST "https://redis-data-service.sprint9.tgcloudenv.ru/test_redis" -H "Content-Type:application/json; charset=utf-8" -d "{\"redis\":{\"host\":\"c-c9qja0hmkcut98r1da5u.rw.mdb.yandexcloud.net\",\"port\":6380,\"password\":\"********\"}}"
```

#### Загрузить информацию о пользователях

```sh
curl -X POST https://redis-data-service.sprint9.tgcloudenv.ru/load_users \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "redis":{
        "host": "c-c9qja0hmkcut98r1da5u.rw.mdb.yandexcloud.net",
        "port": 6380,
        "password": "********"
    }
}
EOF
```

#### Загрузить информацию о ресторанах

```sh
curl -X POST https://redis-data-service.sprint9.tgcloudenv.ru/load_restaurants \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "redis":{
        "host": "c-c9qja0hmkcut98r1da5u.rw.mdb.yandexcloud.net",
        "port": 6380,
        "password": "********"
    }
}
EOF
```

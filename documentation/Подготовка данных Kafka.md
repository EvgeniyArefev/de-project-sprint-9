## Подготовка данных Kafka

#### Проверка что топик создан и работает

```sh
curl -X POST https://order-gen-service.sprint9.tgcloudenv.ru/test_kafka \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "student": "evgeniy-arefev",
    "kafka_connect":{
        "host": "rc1a-7eh3bthue1hn0l4e.mdb.yandexcloud.net",
        "port": 9091,
        "topic": "order-service_orders",
        "producer_name": "producer_consumer",
        "producer_password": "********"
    }
}
EOF
```

#### Зарегистрировать kafka для потока сообщений от бэка

```sh
curl -X POST https://order-gen-service.sprint9.tgcloudenv.ru/register_kafka \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "student": "evgeniy-arefev",
    "kafka_connect":{
        "host": "rc1a-7eh3bthue1hn0l4e.mdb.yandexcloud.net",
        "port": 9091,
        "topic": "order-service_orders",
        "producer_name": "producer_consumer",
        "producer_password": "********"
    }
}
EOF
```

#### Проверить, что сообщения приходят

```sh
docker run \
    -it \
    --name "kcat" \
    --network=host \
    --rm \
    -v "/mnt/c/users/Evgeniy/.kafka/YandexInternalRootCA.crt:/data/CA.pem" \
    edenhill/kcat:1.7.1 -b rc1a-7eh3bthue1hn0l4e.mdb.yandexcloud.net:9091 \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanisms=SCRAM-SHA-512 \
    -X sasl.username=producer_consumer \
    -X sasl.password="********" \
    -X ssl.ca.location=/data/CA.pem \
    -t order-service_orders \
    -C \
    -o beginning
```

#### Удалить поток сообщений

```sh
curl -X POST https://order-gen-service.sprint9.tgcloudenv.ru/delete_kafka \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "student": "evgeniy-arefev"
}
EOF
```

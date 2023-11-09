from datetime import datetime
from logging import Logger
import uuid

from lib.kafka_connect import KafkaConsumer, KafkaProducer
from dds_loader.repository import DdsRepository


class DdsMessageProcessor:
    def __init__(self,
                 consumer: KafkaConsumer,
                 dds_repository: DdsRepository,
                 logger: Logger) -> None:

        self._consumer = consumer
        self._dds_repository = dds_repository
        self._logger = logger
        self._batch_size = 30

    def run(self) -> None:
        self._logger.info(f"{datetime.utcnow()}: START")

        for _ in range(self._batch_size):
            msg = self._consumer.consume()
            if not msg:
                break

            payload = msg['payload']

            user_id = payload['user']['id']
            h_user_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, user_id))

            products = payload['products']

            restaurant_id = payload['restaurant']['id']
            h_restaurant_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, restaurant_id))

            order_id = payload['id']
            h_order_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, str(order_id)))
            order_dt = payload['date']

            load_dt = datetime.now()
            load_src = self._consumer.topic

            self._dds_repository.h_user_insert(h_user_pk, user_id, load_dt, load_src)
            self._dds_repository.h_restaurant_insert(h_restaurant_pk, restaurant_id, load_dt, load_src)
            self._dds_repository.h_order_insert(h_order_pk, order_id, load_dt, order_dt, load_src)

            for product in products:
                product_id = product['id']
                h_product_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, product_id))
                self._dds_repository.h_product_insert(h_product_pk, product_id, load_dt, load_src)

                category_name = product['category']
                h_category_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, category_name))
                self._dds_repository.h_category_insert(h_category_pk, category_name, load_dt, load_src)

                hk_order_product_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, str([h_order_pk, h_product_pk])))
                self._dds_repository.l_order_product_insert(hk_order_product_pk, h_order_pk, h_product_pk, load_dt, load_src)

                hk_product_restaurant_pk = str(uuid.uuid5(uuid.NAMESPACE_DNS, str([h_product_pk, h_restaurant_pk])))
                self._dds_repository.l_product_restaurant(hk_product_restaurant_pk, h_product_pk, h_restaurant_pk, load_dt, load_src)



        self._logger.info(f"{datetime.utcnow()}: FINISH")

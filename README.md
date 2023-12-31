# Проект «Облачные технологии»

### Задача

Реализоват бизнес задачу с использование облачных технологий (провайдет Yandex Cloud).

### Описание

Бизнес-задача — «тегирование гостей» ресторана на основне данных по завершенным заказам.

### Ссылки на реджестри

Service STG `cr.yandex/crpil6ehat9c4rl4hcps/stg_service`  
Service DDS `cr.yandex/crpil6ehat9c4rl4hcps/dds_service`  
Service CDM `cr.yandex/crpil6ehat9c4rl4hcps/cdm_service`

### Исопользуемые технологии

- `Yandex Cloud` (облачный провайдер, на нём будут развернуты все технологии)
- `Docker`
- `Kubernetes`
- `Apache Kafka` (для передачи сообщений между сервисами)
- `Redis` (key-value хранилище)
- `Python` (логика серисов по обработке сообщений)
- `PostgreSql`

### Структура репозитория

- `/solution/service_stg` (код сервиса STG)
- `/solution/service_dds` (код сервиса DDS)
- `/solution/service_cdm` (код сервиса CDM)
- `/solution/ddl_postgresql` (ddl для таблиц сервисов)
- `/documentation` (документация сервиса)

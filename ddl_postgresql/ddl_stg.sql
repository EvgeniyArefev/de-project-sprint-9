create schema if not exists stg;

/*stg.order_events*/
drop table if exists stg.order_events;

create table if not exists stg.order_events (
	id serial not null,
	object_id int not null,
	payload json not null,
	object_type character varying not null,
	sent_dttm timestamp not null,
	constraint order_events_id_pk primary key (id),
	constraint object_id_un_idx unique (object_id)
);
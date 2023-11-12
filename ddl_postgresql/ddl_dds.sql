create schema if not exists dds;

/********/
/* hubs */
/********/

/*h_user*/
drop table if exists dds.h_user cascade;

create table if not exists dds.h_user(
	h_user_pk uuid not null,
	user_id varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint h_user_pk primary key (h_user_pk),
	constraint h_user_user_id_unq unique (user_id)
);

/*h_product*/
drop table if exists dds.h_product cascade;

create table if not exists dds.h_product(
	h_product_pk uuid not null,
	product_id varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint h_product_pk primary key (h_product_pk),
	constraint h_product_product_id_unq unique (product_id)
);

/*h_category*/
drop table if exists dds.h_category cascade;

create table if not exists dds.h_category(
	h_category_pk uuid not null,
	category_name varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint h_category_pk primary key (h_category_pk),
	constraint h_category_category_name_unq unique (category_name)
);

/*h_restaurant*/
drop table if exists dds.h_restaurant cascade;

create table if not exists dds.h_restaurant(
	h_restaurant_pk uuid not null,
	restaurant_id varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint h_restaurant_pk primary key (h_restaurant_pk),
	constraint h_restaurant_restaurant_id_unq unique (restaurant_id)
);

/*h_order*/
drop table if exists dds.h_order cascade;

create table if not exists dds.h_order(
	h_order_pk uuid not null,
	order_id int not null,
	load_dt timestamp not null,
	order_dt timestamp not null,
	load_src varchar not null,
	constraint h_order_pk primary key (h_order_pk),
	constraint h_order_order_id_unq unique (order_id)
);

/*********/
/* links */
/*********/

/*l_order_product*/
drop table if exists dds.l_order_product;

create table if not exists dds.l_order_product(
	hk_order_product_pk uuid not null,
	h_order_pk uuid not null,
	h_product_pk uuid not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint hk_order_product_pk primary key (hk_order_product_pk),
	constraint h_order_pk_fk foreign key (h_order_pk) references dds.h_order (h_order_pk),
	constraint h_product_pk_fk foreign key (h_product_pk) references dds.h_product (h_product_pk)
);

/*l_product_restaurant*/
drop table if exists dds.l_product_restaurant;

create table if not exists dds.l_product_restaurant(
	hk_product_restaurant_pk uuid not null,
	h_product_pk uuid not null,
	h_restaurant_pk uuid not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint hk_product_restaurant_pk primary key (hk_product_restaurant_pk),
	constraint h_product_pk_fk foreign key (h_product_pk) references dds.h_product (h_product_pk),
	constraint h_restaurant_pk_fk foreign key (h_restaurant_pk) references dds.h_restaurant (h_restaurant_pk)
);

/*l_product_category*/
drop table if exists dds.l_product_category;

create table if not exists dds.l_product_category(
	hk_product_category_pk uuid not null,
	h_product_pk uuid not null,
	h_category_pk uuid not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint hk_product_category_pk primary key (hk_product_category_pk),
	constraint h_product_pk_fk foreign key (h_product_pk) references dds.h_product (h_product_pk),
	constraint h_category_pk_fk foreign key (h_category_pk) references dds.h_category (h_category_pk)
);

/*l_order_user*/
drop table if exists dds.l_order_user;

create table if not exists dds.l_order_user(
	hk_order_user_pk uuid not null,
	h_order_pk uuid not null,
	h_user_pk uuid not null,
	load_dt timestamp not null,
	load_src varchar not null,
	constraint hk_order_user_pk primary key (hk_order_user_pk),
	constraint h_order_pk_fk foreign key (h_order_pk) references dds.h_order (h_order_pk),
	constraint h_user_pk_fk foreign key (h_user_pk) references dds.h_user (h_user_pk)
);

/**************/
/* satellites */
/**************/

/*s_user_names*/
drop table if exists dds.s_user_names;

create table if not exists dds.s_user_names(
	h_user_pk uuid not null,
	username varchar not null,
	userlogin varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	hk_user_names_hashdiff uuid not null,
	constraint hk_user_names_hashdiff_pk primary key (hk_user_names_hashdiff),
	constraint h_user_pk_fk foreign key (h_user_pk) references dds.h_user (h_user_pk)
);

/*s_product_names*/
drop table if exists dds.s_product_names;

create table if not exists dds.s_product_names(
	h_product_pk uuid not null,
	name varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	hk_product_names_hashdiff uuid not null,
	constraint hk_product_names_hashdiff_pk primary key (hk_product_names_hashdiff),
	constraint h_product_pk_fk foreign key (h_product_pk) references dds.h_product (h_product_pk)
);

/*s_restaurant_names*/
drop table if exists dds.s_restaurant_names;

create table if not exists dds.s_restaurant_names(
	h_restaurant_pk uuid not null,
	name varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	hk_restaurant_names_hashdiff uuid not null,
	constraint hk_restaurant_names_hashdiff_pk primary key (hk_restaurant_names_hashdiff),
	constraint h_restaurant_pk_fk foreign key (h_restaurant_pk) references dds.h_restaurant (h_restaurant_pk)
);

/*s_order_cost*/
drop table if exists dds.s_order_cost;

create table if not exists dds.s_order_cost(
	h_order_pk uuid not null,
	cost decimal(19, 5) not null,
	payment decimal(19, 5) not null,
	load_dt timestamp not null,
	load_src varchar not null,
	hk_order_cost_hashdiff uuid not null,
	constraint hk_order_cost_hashdiff_pk primary key (hk_order_cost_hashdiff),
	constraint h_order_cost_pk_fk foreign key (h_order_pk) references dds.h_order (h_order_pk),
	constraint check_cost check (cost >= 0),
	constraint check_payment check (payment >= 0)
);

/*s_order_status*/
drop table if exists dds.s_order_status;

create table if not exists dds.s_order_status(
	h_order_pk uuid not null,
	status varchar not null,
	load_dt timestamp not null,
	load_src varchar not null,
	hk_order_status_hashdiff uuid not null,
	constraint hk_order_status_hashdiff_pk primary key (hk_order_status_hashdiff),
	constraint s_order_status_fk foreign key (h_order_pk) references dds.h_order (h_order_pk)
);

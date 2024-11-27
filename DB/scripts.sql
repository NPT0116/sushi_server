﻿GO
IF NOT EXISTS (SELECT "name" FROM sys.databases WHERE name = 'rms_final')
BEGIN
    CREATE DATABASE rms_final;
END
GO
use rms_final;

-- GO
-- drop table if exists employee
-- CREATE TABLE employee (
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	dob date,
-- 	gender varchar(6),
-- 	"start_date" date,
-- 	resign_date date,
-- 	CONSTRAINT pk_employee PRIMARY KEY (id),
-- 	branch_id bigint not null,
-- 	department_id bigint not null,
-- 	account_id bigint not null,
-- )
-- GO
-- drop table if exists branch
-- CREATE TABLE branch (
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	"address" nvarchar(255) not null,
-- 	phone varchar(11) not null,
-- 	opening_time time not null,
-- 	closing_time time not null,
-- 	car_parking_status bit,
-- 	motor_parking_status bit,
-- 	ship_status bit not null,
-- 	total_table bigint not null, 
-- 	CONSTRAINT pk_branch PRIMARY KEY (id),
-- 	menu_id bigint not null,
-- 	manager_id bigint not null,
-- )
-- GO
-- drop table if exists department
-- CREATE TABLE department(
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	base_salary bigint not null,
-- 	CONSTRAINT pk_department PRIMARY KEY(id)
-- )
-- GO
-- drop table if exists reservation
-- CREATE TABLE reservation (
-- 	id bigint IDENTITY(1,1),
-- 	dated_on datetime not null,
-- 	note nvarchar(255),
-- 	"status" varchar(20) not null CHECK ("status" IN ('confirmed', 'canceled', 'not_completed')),
-- 	CONSTRAINT pk_reservation PRIMARY KEY (id),
-- 	ordered_by bigint not null,
-- 	customer_id bigint not null,
-- 	branch_id bigint not null,
-- 	order_id bigint not null,
-- 	table_id bigint not null,
-- );
-- GO
-- drop table if exists customer
-- CREATE TABLE customer (
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	dob date,
-- 	gender varchar(6),
-- 	citizen_id char(12),
-- 	phone varchar(11) not null,
-- 	email varchar(255),
-- 	created_by bigint not null,
-- 	CONSTRAINT pk_customer PRIMARY KEY (id),
-- 	account_id bigint not null,
-- );
-- GO
-- drop table if exists "card"
-- CREATE TABLE "card"(
-- 	id bigint IDENTITY(1,1),
-- 	valid bit not null,
-- 	accumulated_pobigint bigint not null,
-- 	accumulated_day bigint not null,
-- 	"start_date" date not null,
-- 	CONSTRAINT pk_card PRIMARY KEY (id),
-- 	"owner" bigint not null,
-- 	"created_by" bigint not null,
-- 	ranking_id bigint not null,
-- )
-- GO
-- drop table if exists ranking
-- CREATE TABLE ranking(
-- 	id bigint IDENTITY(1,1),
-- 	"name" varchar(50) not null,
-- 	require_point bigint not null,
-- 	discount bigint not null,
-- 	upgrade_point bigint not null,
-- 	CONSTRAINT pk_ranking PRIMARY KEY (id)
-- )
-- GO
-- drop table if exists "order"
-- CREATE TABLE "order"(
-- 	id bigint IDENTITY(1,1),
-- 	total bigint not null,
-- 	last_modified datetime,
-- 	"status" varchar(12) not null CHECK ("status" in ('placed', 'in_progress','doned')),
-- 	reservation_id bigint,
-- 	CONSTRAINT pk_order PRIMARY KEY (id)
-- );
-- GO
-- drop table if exists order_detail
-- CREATE TABLE order_detail(
-- 	id bigint IDENTITY(1,1),
-- 	"status" varchar(12) not null CHECK ("status" in ('placed', 'in_progress','doned')),
-- 	price bigint not null,
-- 	quantity bigint not null,
-- 	CONSTRAINT pk_order_detail PRIMARY KEY (id),
-- 	dish_id bigint not null,
-- 	order_id bigint not null,
-- );
-- GO
-- drop table if exists invoice
-- CREATE TABLE invoice(
-- 	id bigint IDENTITY(1,1),
-- 	total bigint not null,
-- 	after_discount bigint not null,
-- 	payment_method varchar(25),
-- 	bonus_point bigint not null,
-- 	paid bit not null,
-- 	dated_on datetime,
-- 	CONSTRAINT pk_invoice PRIMARY KEY (id),
-- 	order_id bigint not null
-- )
-- GO
-- drop table if exists survey
-- CREATE TABLE survey(
-- 	id bigint IDENTITY(1,1),
-- 	-- fill more field
-- 	invoice_id bigint not null
-- )
-- GO
-- drop table if exists menu
-- CREATE TABLE menu(
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	"description" nvarchar(255),
-- 	CONSTRAINT pk_menu PRIMARY KEY (id)
-- )
-- GO
-- drop table if exists section
-- CREATE TABLE section(
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255) not null,
-- 	"description" nvarchar(255),
-- 	CONSTRAINT pk_section PRIMARY KEY (id),
-- 	-- fill foreign key
-- )
-- GO
-- drop table if exists dish
-- CREATE table dish (
-- 	id bigint IDENTITY(1,1),
-- 	"name" nvarchar(255)not null,
-- 	"description" nvarchar(255),
-- 	price bigint not null,
-- 	CONSTRAINT pk_dish PRIMARY KEY (id)
-- )
-- GO
-- drop table if exists branch_dish
-- CREATE TABLE branch_dish(
-- 	id bigint IDENTITY(1,1),
-- 	servation_status bit not null,
-- 	ship_status bit not null,
-- 	"description" nvarchar(255),
-- 	CONSTRAINT pk_branch_dish PRIMARY KEY (id)
-- )
-- GO
-- drop table if exists table_detail
-- CREATE TABLE table_detail(
-- 	id bigint IDENTITY(1,1),
-- 	max_capacity bigint not null,
-- 	"status" varchar(10) not null CHECK ("status" in ('vacant','reserved','occupied')), -- vacant,reserved,occupied
-- 	CONSTRAINT pk_table_detail PRIMARY KEY (id),
-- 	branch_id bigint,
-- )
-- GO
--CREATE TABLE work_history(
--	id bigint IDENTITY(1,1),
--	"start_date" date not null,
--	"resigned_date" date,
--	CONSTRAINT pk_work_history PRIMARY KEY (id)
--)
-- GO
-- drop table if exists account_system
-- CREATE TABLE account_system(
-- 	id bigint IDENTITY(1,1),
-- 	username varchar(20) not null,
-- 	password varchar(255) not null,
-- 	role varchar(20) not null ,
-- 	CONSTRAINT pk_account_system PRIMARY KEY (id)
-- )
-- -- CONSTRAINT 
-- GO
-- ALTER TABLE employee
-- ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(id),
-- 	CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id) REFERENCES branch(id),
-- 	CONSTRAINT fk_employee_account_system FOREIGN KEY (account_id) REFERENCES account_system(id)
-- GO
-- ALTER TABLE branch
-- ADD CONSTRAINT fk_branch_menu FOREIGN KEY (menu_id) REFERENCES menu(id),
-- 	CONSTRAINT fk_branch_manager FOREIGN KEY (manager_id) REFERENCES employee(id)
-- GO
-- ALTER TABLE customer
-- ADD CONSTRAINT fk_customer_account_system FOREIGN KEY (account_id) REFERENCES account_system(id)
-- GO
-- ALTER TABLE reservation
-- ADD CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id) REFERENCES customer(id),
-- 	CONSTRAINT fk_reservation_branch FOREIGN KEY (branch_id) REFERENCES branch(id),
-- 	CONSTRAINT fk_reservation_employee FOREIGN KEY (ordered_by) REFERENCES employee(id),
-- 	CONSTRAINT fk_reservation_order FOREIGN KEY (order_id) REFERENCES "order"(id),
-- 	CONSTRAINT fk_reservation_table_detail FOREIGN KEY (table_id) REFERENCES table_detail(id)
-- GO

-- ALTER TABLE "card"
-- ADD CONSTRAINT fk_card_customer FOREIGN KEY ("owner") REFERENCES customer(id),
-- 	CONSTRAINT fk_card_employee FOREIGN KEY (created_by) REFERENCES employee(id),
-- 	CONSTRAINT fk_card_ranking FOREIGN KEY (ranking_id) REFERENCES ranking(id)
-- GO

-- ALTER TABLE "order_detail"
-- ADD CONSTRAINT fk_order_detail_dish FOREIGN KEY (dish_id) REFERENCES dish(id),
-- 	CONSTRAINT fk_order_detail_order FOREIGN KEY (order_id) REFERENCES "order"(id)
-- GO
-- ALTER TABLE invoice
-- ADD CONSTRAINT fk_invoice_order FOREIGN KEY (order_id) REFERENCES "order"(id)

-- ALTER TABLE survey
-- ADD CONSTRAINT fk_survey_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id)

-- ALTER TABLE table_detail
-- ADD CONSTRAINT fk_table_detail_branch FOREIGN KEY (branch_id) REFERENCES branch(id)

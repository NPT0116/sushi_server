GO
IF NOT EXISTS (SELECT "name" FROM sys.databases WHERE name = 'rms_final')
BEGIN
    CREATE DATABASE rms_final;
END
GO
use rms_final;

GO
drop table if exists employee
CREATE TABLE employee (
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	dob date,
	gender varchar(6),
	"start_date" date,
	resign_date date,
	CONSTRAINT pk_employee PRIMARY KEY (id),
	branch_id bigint not null,
	department_id bigint not null,
	account_id bigint not null,
)
GO
drop table if exists branch
CREATE TABLE branch (
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	"address" nvarchar(255) not null,
	phone varchar(11) not null,
	opening_time time not null,
	closing_time time not null,
	car_parking_status bit,
	motor_parking_status bit,
	ship_status bit not null,
	total_table bigint not null, 
	CONSTRAINT pk_branch PRIMARY KEY (id),
	menu_id bigint not null,
	manager_id bigint not null,
)
GO
drop table if exists department
CREATE TABLE department(
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	base_salary bigint not null,
	CONSTRAINT pk_department PRIMARY KEY(id)
)
GO
drop table if exists reservation
CREATE TABLE reservation (
	id bigint IDENTITY(1,1),
	dated_on datetime not null,
	note nvarchar(255),
	"status" varchar(20) not null CHECK ("status" IN ('confirmed', 'canceled', 'not_completed')),
	CONSTRAINT pk_reservation PRIMARY KEY (id),
	ordered_by bigint not null,
	customer_id bigint not null,
	branch_id bigint not null,
	order_id bigint not null,
	table_id bigint not null,
);
GO
drop table if exists customer
CREATE TABLE customer (
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	dob date,
	gender varchar(6),
	citizen_id char(12),
	phone varchar(11) not null,
	email varchar(255),
	created_by bigint not null,
	CONSTRAINT pk_customer PRIMARY KEY (id),
	account_id bigint not null,
);
GO
drop table if exists "card"
CREATE TABLE "card"(
	id bigint IDENTITY(1,1),
	valid bit not null,
	accumulated_pobigint bigint not null,
	accumulated_day bigint not null,
	"start_date" date not null,
	CONSTRAINT pk_card PRIMARY KEY (id),
	"owner" bigint not null,
	"created_by" bigint not null,
	ranking_id bigint not null,
)
GO
drop table if exists ranking
CREATE TABLE ranking(
	id bigint IDENTITY(1,1),
	"name" varchar(50) not null,
	require_point bigint not null,
	discount bigint not null,
	upgrade_point bigint not null,
	CONSTRAINT pk_ranking PRIMARY KEY (id)
)
GO
drop table if exists "order"
CREATE TABLE "order"(
	id bigint IDENTITY(1,1),
	total bigint not null,
	last_modified datetime,
	"status" varchar(12) not null CHECK ("status" in ('placed', 'in_progress','doned')),
	reservation_id bigint,
	CONSTRAINT pk_order PRIMARY KEY (id)
);
GO
drop table if exists order_detail
CREATE TABLE order_detail(
	id bigint IDENTITY(1,1),
	"status" varchar(12) not null CHECK ("status" in ('placed', 'in_progress','doned')),
	price bigint not null,
	quantity bigint not null,
	CONSTRAINT pk_order_detail PRIMARY KEY (id),
	dish_id bigint not null,
	order_id bigint not null,
);
GO
drop table if exists invoice
CREATE TABLE invoice(
	id bigint IDENTITY(1,1),
	total bigint not null,
	after_discount bigint not null,
	payment_method varchar(25),
	bonus_point bigint not null,
	paid bit not null,
	dated_on datetime,
	CONSTRAINT pk_invoice PRIMARY KEY (id),
	order_id bigint not null
)
GO
drop table if exists survey
CREATE TABLE survey(
	id bigint IDENTITY(1,1),
	-- fill more field
	invoice_id bigint not null
)
GO
drop table if exists menu
CREATE TABLE menu(
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	"description" nvarchar(255),
	CONSTRAINT pk_menu PRIMARY KEY (id)
)
GO
drop table if exists section
CREATE TABLE section(
	id bigint IDENTITY(1,1),
	"name" nvarchar(255) not null,
	"description" nvarchar(255),
	CONSTRAINT pk_section PRIMARY KEY (id),
	-- fill foreign key
)
GO
drop table if exists dish
CREATE table dish (
	id bigint IDENTITY(1,1),
	"name" nvarchar(255)not null,
	"description" nvarchar(255),
	price bigint not null,
	CONSTRAINT pk_dish PRIMARY KEY (id)
)
GO
drop table if exists branch_dish
CREATE TABLE branch_dish(
	id bigint IDENTITY(1,1),
	servation_status bit not null,
	ship_status bit not null,
	"description" nvarchar(255),
	CONSTRAINT pk_branch_dish PRIMARY KEY (id)
)
GO
drop table if exists table_detail
CREATE TABLE table_detail(
	id bigint IDENTITY(1,1),
	max_capacity bigint not null,
	"status" varchar(10) not null CHECK ("status" in ('vacant','reserved','occupied')), -- vacant,reserved,occupied
	CONSTRAINT pk_table_detail PRIMARY KEY (id),
	branch_id bigint,
)
GO
--CREATE TABLE work_history(
--	id bigint IDENTITY(1,1),
--	"start_date" date not null,
--	"resigned_date" date,
--	CONSTRAINT pk_work_history PRIMARY KEY (id)
--)
GO
drop table if exists account_system
CREATE TABLE account_system(
	id bigint IDENTITY(1,1),
	username varchar(20) not null,
	password varchar(255) not null,
	role varchar(20) not null ,
	CONSTRAINT pk_account_system PRIMARY KEY (id)
)
-- CONSTRAINT 
GO
ALTER TABLE employee
ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(id),
	CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id) REFERENCES branch(id),
	CONSTRAINT fk_employee_account_system FOREIGN KEY (account_id) REFERENCES account_system(id)
GO
ALTER TABLE branch
ADD CONSTRAINT fk_branch_menu FOREIGN KEY (menu_id) REFERENCES menu(id),
	CONSTRAINT fk_branch_manager FOREIGN KEY (manager_id) REFERENCES employee(id)
GO
ALTER TABLE customer
ADD CONSTRAINT fk_customer_account_system FOREIGN KEY (account_id) REFERENCES account_system(id)
GO
ALTER TABLE reservation
ADD CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id) REFERENCES customer(id),
	CONSTRAINT fk_reservation_branch FOREIGN KEY (branch_id) REFERENCES branch(id),
	CONSTRAINT fk_reservation_employee FOREIGN KEY (ordered_by) REFERENCES employee(id),
	CONSTRAINT fk_reservation_order FOREIGN KEY (order_id) REFERENCES "order"(id),
	CONSTRAINT fk_reservation_table_detail FOREIGN KEY (table_id) REFERENCES table_detail(id)
GO

ALTER TABLE "card"
ADD CONSTRAINT fk_card_customer FOREIGN KEY ("owner") REFERENCES customer(id),
	CONSTRAINT fk_card_employee FOREIGN KEY (created_by) REFERENCES employee(id),
	CONSTRAINT fk_card_ranking FOREIGN KEY (ranking_id) REFERENCES ranking(id)
GO

ALTER TABLE "order_detail"
ADD CONSTRAINT fk_order_detail_dish FOREIGN KEY (dish_id) REFERENCES dish(id),
	CONSTRAINT fk_order_detail_order FOREIGN KEY (order_id) REFERENCES "order"(id)
GO
ALTER TABLE invoice
ADD CONSTRAINT fk_invoice_order FOREIGN KEY (order_id) REFERENCES "order"(id)

ALTER TABLE survey
ADD CONSTRAINT fk_survey_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id)

ALTER TABLE table_detail
ADD CONSTRAINT fk_table_detail_branch FOREIGN KEY (branch_id) REFERENCES branch(id)

-- trigger
-- 1 Quản lý chi nhánh làm việc ở vị trí quản lý và là duy nhất->  context: branch, employee
GO
CREATE OR ALTER TRIGGER branch_manager ON branch
AFTER INSERT, UPDATE
AS
BEGIN
	if update(manager_id)
	begin
		if exists ( select * from inserted i where (select count(branch.manager_id) from branch where branch.manager_id = i.manager_id) >= 2)
		begin
			raiserror('quan ly chi quan ly duy nhat mot chi nhanh',16,1);
			rollback tran;
		end
	end
END
GO
CREATE OR ALTER TRIGGER employee_manager ON employee
AFTER UPDATE
AS
BEGIN
	if update(department_id)
	begin
		-- neu deleted quan ly && co quan ly && inserted khong phai quan ly
		if exists ( select * from deleted d ,department dpm where dpm.id = d.department_id and  dpm."name" like '%manager%')
			and exists ( select * from deleted d, branch b where b.manager_id = d.id)
			and exists ( select * from inserted i, department dpm where dpm.id = i.department_id and not(dpm."name" like '%manager%'))
		begin
			raiserror('khong the thay doi vi tri vi nhan vien dang quan ly chi nhanh',16,1);
			rollback tran;
		end
	end
END
GO
-- 2 Submit reservation -> Một đặt chỗ là hợp lệ khi thỏa: nhân viên của chi nhánh đó đặt chỗ, chỗ phải trống, lượng người phù hợp, trong khung giờ mở cửa chi nhánh.
CREATE OR ALTER PROCEDURE submit_reservation @dated_on DATETIME, @note NVARCHAR(255), @status VARCHAR(20),
    @ordered_by BIGINT,
    @customer_id BIGINT,
    @branch_id BIGINT,
    @order_id BIGINT,
    @table_id BIGINT
AS
BEGIN
	-- business rule
	-- trigger update table_detail (status)
	commit tran;
END
-- 3 Mỗi khách hàng có tối đa 1 thẻ thành viên hợp lệ tại thời điểm đó
GO
CREATE OR ALTER TRIGGER card_customer ON "card"
AFTER INSERT, UPDATE
AS
BEGIN
	if UPDATE("owner")
	begin
		if exists (select * from inserted i where (select count(*) from "card" as c where c."owner" = i."owner" and c.valid = 1) > 1)
		begin
			raiserror(N'Mỗi khách hàng có tối đa 1 thẻ thành viên hợp lệ tại thời điểm đó',16,1);
			rollback tran;
		end
	end
END
GO
-- 4 Xuất hóa đơn khi và chỉ khi đơn hàng hoàn thành -> trigger update order -> checkout reservation
CREATE OR ALTER PROCEDURE create_invoice
	@total bigint ,
	@after_discount bigint ,
	@payment_method varchar(25) = 'cash',
	@bonus_point bigint ,
	@paid bit = 0,
	@dated_on datetime = GETDATE,
	@order_id bigint 
AS
BEGIN
	-- business rule and validation
	INSERT INTO invoice (after_discount, payment_method, bonus_point, paid, dated_on, order_id)
    VALUES (@after_discount, @payment_method, @bonus_point, @paid, @dated_on, @order_id);
	commit tran;
END
GO
-- 5 Tổng thành tiền trên hóa đơn đồng bộ với đơn hàng  và chi tiết đơn hàng đó
CREATE OR ALTER TRIGGER sync_total_invoice ON invoice
AFTER INSERT,UPDATE
AS
BEGIN
	if UPDATE(total)
	-- trigger update on invoice(total) by order_id
	commit tran
END
GO
CREATE OR ALTER TRIGGER sync_total_order ON "order"
AFTER INSERT,UPDATE
AS
BEGIN
	if UPDATE(total)
	-- trigger update on order(total) by order_detail
	commit tran
END
-- 6 Đơn hàng hoàn thành thì không thể thêm món trên đơn hàng nữa
-- 7 Tổng điểm thưởng phải đồng bộ với tổng hóa đơn khách hàng đã thanh toán trong năm đó(1 điểm thưởng = 100.000VNĐ) --> trigger kiểm tra trên invoice
-- 8 Đặt món là hợp lệ khi món đó có được phục vụ tại chi nhánh đó
GO
CREATE OR ALTER PROCEDURE submit_order_detail
    @status VARCHAR(12) = 'placed',
    @price BIGINT,
    @quantity BIGINT,
    @dish_id BIGINT,
    @order_id BIGINT
AS
BEGIN
        -- Business rule: Insert order detail
        INSERT INTO order_detail (order_id, dish_id, price, quantity, "status")
        VALUES (@order_id, @dish_id, @price, @quantity, @status) 
        COMMIT TRANSACTION
END
GO

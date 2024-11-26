use rms;
-- trigger
-- 1 Quản lý chi nhánh làm việc ở vị trí quản lý và là duy nhất->  context: branch, employee
GO
CREATE OR ALTER TRIGGER branch_manager ON branches
AFTER INSERT, UPDATE
AS
BEGIN
	if update(manager_id)
	begin
		if exists ( select * from inserted i where (select count(branches.ManagerId) from branches where branches.ManagerId = i.ManagerId) >= 2)
		begin
			raiserror('quan ly chi quan ly duy nhat mot chi nhanh',16,1);
			rollback tran;
		end
	end
END
GO
CREATE OR ALTER TRIGGER employee_manager ON employees
AFTER UPDATE
AS
BEGIN
	if update(department_id)
	begin
		-- neu deleted quan ly && co quan ly && inserted khong phai quan ly
		if exists ( select * from deleted d ,departments dpm where dpm.DepartmentId = d.DepartmentId and  dpm.DepartmentName like '%manager%')
			and exists ( select * from deleted d, branches b where b.ManagerId = d.id)
			and exists ( select * from inserted i, Departments dpm where dpm.DepartmentId = i.DepartmentId and not(dpm.DepartmentName like '%manager%'))
		begin
			raiserror('khong the thay doi vi tri vi nhan vien dang quan ly chi nhanh',16,1);
			rollback tran;
		end
	end
END
GO


-- 3 Mỗi khách hàng có tối đa 1 thẻ thành viên hợp lệ tại thời điểm đó
GO
CREATE OR ALTER TRIGGER card_customer ON cards
AFTER INSERT, UPDATE
AS
BEGIN
	if UPDATE("owner")
	begin
		if exists (select * from inserted i where (select count(*) from cards as c where c.CustomerId = i.CustomerId and c.valid = 1) > 1)
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
	INSERT INTO invoices (after_discount, payment_method, bonus_point, paid, dated_on, order_id)
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
CREATE OR ALTER TRIGGER sync_total_order ON 
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

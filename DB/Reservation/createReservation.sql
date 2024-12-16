

-- ALTER TABLE [dbo].[Reservation]
-- -- ALTER COLUMN [OrderedBy] UNIQUEIDENTIFIER NULL;
-- ALTER COLUMN [TableId] UNIQUEIDENTIFIER NULL;


select top 1 * from Reservation
GO
CREATE OR ALTER PROCEDURE customerSubmitReservation
    @note NVARCHAR(50),
    @datedOn NVARCHAR(50),  -- Input as VARCHAR, will be converted to DATETIME2
    @customerId UNIQUEIDENTIFIER,
    @branchId UNIQUEIDENTIFIER,
    @totalPeople INT,
    @id UNIQUEIDENTIFIER OUT
AS
BEGIN
    -- Kiểm tra xem customerId có tồn tại trong bảng Customers không
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerId = @customerId)
    BEGIN
        RAISERROR('Cant find customer id in db', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem branchId có tồn tại trong bảng Branches không
    IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @branchId)
    BEGIN
        RAISERROR('Cant find branch id in db', 16, 1);
        RETURN;
    END

 IF CHARINDEX('T', @datedOn) > 0 AND LEN(@datedOn) = 16
    BEGIN
        SET @datedOn = @datedOn + ':00';  -- Thêm ":00" vào cuối để đảm bảo phần giây
    END

    -- Chuyển đổi @datedOn từ NVARCHAR sang DATETIME2
    DECLARE @convertedDatedOn DATETIME2;
    SET @convertedDatedOn = CAST(@datedOn AS DATETIME2);

    -- Tạo một ID mới cho Reservation
    SET @id = NEWID();

    -- Insert vào bảng Reservation
    INSERT INTO Reservation (id, Note, DatedOn, CustomerId, BranchId, TotalPeople, [Status])
    VALUES (@id, @note, @convertedDatedOn, @customerId, @branchId, @totalPeople, 0);

END;





go
create or alter PROC createOrderFromReservation
@reservationId UNIQUEIDENTIFIER,
@orderId UNIQUEIDENTIFIER OUT
AS
BEGIN
    if not exists (select 1 from Reservation where @reservationId = Id)
    BEGIN
        RAISERROR('cant find reservationId in db', 16,1);
        RETURN;
    END 
    set @orderId = NEWID();
    insert into Orders (Id, Total, LastModified, [Status], ReservationId)
    values (@orderId, 0, GETDATE(), 2, @reservationId )
END

go
create or alter PROCEDURE createOrderDetailFromOrder
@orderId UNIQUEIDENTIFIER,
@dishId UNIQUEIDENTIFIER,
@branchId UNIQUEIDENTIFIER,
@quantity int
AS
BEGIN
    if not exists (select 1 from Dishes where DishId = @dishId)
    BEGIN
        RAISERROR('dish not found in db', 16,1);
        RETURN;
    END
    if not exists (select 1 from BranchDishes where DishId = @dishId and BranchId = @branchId and [Status] =  1)
    BEGIN
        RAISERROR('dish is not available in this branch', 16,1);
        RETURN;
    END
    INSERT into OrderDetail(id, [Status], Price , Quantity , DishId, OrderId)
    VALUES(NEWID(), 2 , (select CurrentPrice from Dishes where DishId = @dishId), @quantity, @dishId, @orderId)
END







select top 1 * from Customers
select top 1 * from Branches
select top 1 * from reservation Order by  DatedOn desc
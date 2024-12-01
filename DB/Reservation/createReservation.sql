

-- ALTER TABLE [dbo].[Reservation]
-- ALTER COLUMN [OrderedBy] UNIQUEIDENTIFIER NULL;
-- ALTER COLUMN [TableId] UNIQUEIDENTIFIER NULL;


select top 1 * from Reservation
go
create or alter PROCEDURE customerSubmitReservation
@note NVARCHAR(50),
@datedOn NVARCHAR(50),
@customerId UNIQUEIDENTIFIER,
@branchId UNIQUEIDENTIFIER,
@totalPeople INT,
@id UNIQUEIDENTIFIER OUT
AS
BEGIN
    if not EXISTS (select 1 from Customers where CustomerId = @customerId)
    BEGIN
        RAISERROR('cant find customer id in db', 16,1 );
        RETURN;
    END

    if not EXISTS (select 1 from Branches where BranchId = @branchId)
    BEGIN
        RAISERROR('cant find branch id in db', 16,1 );
        RETURN;
    END
    set @id = NEWID();
    insert into Reservation (id, Note,DatedOn, CustomerId, BranchId, TotalPeople, [Status])
    VALUES(@id, @note, @datedOn, @customerId, @branchId , @totalPeople, 0)

END


select top 1 * from Orders

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
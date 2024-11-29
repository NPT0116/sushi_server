




GO
create or alter PROCEDURE getDetailReservationCards
@branchId UNIQUEIDENTIFIER,
@dateOn DATE
AS
BEGIN
    select  
    r.Id as ReservationId,
    r.CustomerId as CustomerId,
    c.Name as CustomerName,
    r.BranchId as BranchId,
    b.Name as BranchName,
    r.[Status] as Status,
    r.DatedOn as DatedOn,
    td.TableNumber as TableNumber,
    r.TotalPeople as TotalPeople ,
    o.Total as TotalPrice,
    o.Id as OrderID
    from Reservation r join Customers c on c.CustomerId = r.CustomerId 
    join branches b on b.BranchId = r.BranchId
    join TableDetail td on td.Id = r.TableId
    join ORDERs o on o.ReservationId = r.Id
    where r.BranchId = @branchId and r.DatedOn = @dateOn 
END

go

EXEC getDetailReservationCards @branchId = 'f93abcea-3ecc-4133-98b5-a5dcbd8b9938', @dateOn = '2023-12-12 00:00:00.0000000'

GO
CREATE OR ALTER PROCEDURE getOrderDetailsByReservationId
    @reservationId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT 
        od.Id AS OrderDishId,
        od.Price AS Price,
        od.Quantity AS Quantity,
        od.DishId AS DishId,
        d.DishName AS DishName
    FROM OrderDetail od
    JOIN Orders o ON o.Id = od.OrderId  
    JOIN Dishes d ON d.DishId = od.DishId
    WHERE o.ReservationId = @reservationId;
END


EXEC getOrderDetailsByReservationId @reservationId = 'f17aa3e7-af29-4c23-b066-a39217f7eab6';


SELECT TOP 5 * 
FROM Reservation
ORDER BY NEWID();

    SELECT 
        od.Id AS OrderDishId,
        od.Price AS Price,
        od.Quantity AS Quantity,
        od.DishId AS DishId,
        d.DishName AS DishName
    FROM OrderDetail od
    JOIN Orders o ON o.Id = od.OrderId  
    JOIN Dishes d ON d.DishId = od.DishId
    WHERE o.ReservationId = @reservationId;

select d.DishName from Reservation r join Orders o on o.ReservationId = r.Id join OrderDetail od on od.OrderId = o.Id JOIN Dishes d ON d.DishId = od.DishId   where r.Id = 'f17aa3e7-af29-4c23-b066-a39217f7eab6'

select * from Reservation
select count(*) from Orders
select top 10 * from Customers

SELECT *
from Cards
where CustomerId = '9f3c1145-9556-4ae2-976e-006f010232fe'
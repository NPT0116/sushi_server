



GO
CREATE OR ALTER PROCEDURE getDetailReservationCards
@branchId UNIQUEIDENTIFIER,
@dateOn DATE
AS
BEGIN
    SELECT  
        r.Id AS ReservationId,
        r.CustomerId AS CustomerId,
        c.Name AS CustomerName,
        r.BranchId AS BranchId,
        b.Name AS BranchName,
        r.[Status] AS Status,
        CAST(r.DatedOn AS DATE) AS DatedOn,  -- Ép kiểu DatedOn thành DATE
        td.TableNumber AS TableNumber,  -- TableNumber chỉ trả về khi có TableId
        r.TotalPeople AS TotalPeople,
        o.Total AS TotalPrice,
        o.Id AS OrderID,
        r.OrderedBy AS OrderBy,  -- Trả về OrderBy nếu có (có thể NULL)
        r.TableId AS TableId  -- Trả về TableId nếu có (có thể NULL)
    FROM Reservation r
    LEFT JOIN Customers c ON c.CustomerId = r.CustomerId 
    LEFT JOIN Branches b ON b.BranchId = r.BranchId
    LEFT JOIN TableDetail td ON td.Id = r.TableId  -- Sử dụng LEFT JOIN để tránh việc TableNumber không tồn tại khi TableId là NULL
    LEFT JOIN Orders o ON o.ReservationId = r.Id  -- Liên kết với bảng Orders
    WHERE r.BranchId = @branchId 
    AND CAST(r.DatedOn AS DATE) = @dateOn  -- So sánh DatedOn đã được ép kiểu với @dateOn
    -- Có thể lọc thêm status nếu cần, ví dụ:
    -- AND (r.Status = 0 OR r.Status = 1)  -- Cho phép cả trạng thái đã được xử lý (1) và chưa xử lý (0)
END



go

EXEC getDetailReservationCards @branchId = '9f3142df-065d-4ca9-bf07-1017fd4eff43', @dateOn = '2024-12-01'
 
 select * from Branches
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



select GETDATE() as  today

select top 1 * from customers

select top 1 * from Reservation ORDER by DatedOn desc

select top 1 * from Employees where BranchId = '04ef2e1d-aa27-4194-b2e5-c87cfd84cd4e'

select   * from TableDetail tb join Branches b on b.BranchId = tb.BranchId where b.BranchId = '04ef2e1d-aa27-4194-b2e5-c87cfd84cd4e' and status = 0

select top 1 * from Orders where ReservationId = '1a7b42c8-209a-4c0d-af3f-10388a9e3322'
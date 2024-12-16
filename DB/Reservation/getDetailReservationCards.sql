



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
        r.DatedOn  AS DatedOn,  -- Ép kiểu DatedOn thành DATE
        td.TableNumber AS TableNumber,  -- TableNumber chỉ trả về khi có TableId
        r.TotalPeople AS TotalPeople,
        o.Total AS TotalPrice,
        o.Id AS OrderID,
        r.OrderedBy AS OrderBy,  -- Trả về OrderBy nếu có (có thể NULL)
        r.TableId AS TableId  -- Trả về TableId nếu có (có thể NULL)
    FROM Reservation r
    LEFT JOIN Customers c ON c.CustomerId = r.CustomerId 
    LEFT JOIN Branches b ON b.BranchId = r.BranchId
    LEFT JOIN TableDetail td ON td.TableId = r.TableId  -- Sử dụng LEFT JOIN để tránh việc TableNumber không tồn tại khi TableId là NULL
    LEFT JOIN Orders o ON o.ReservationId = r.Id  -- Liên kết với bảng Orders
    WHERE r.BranchId = @branchId 
    AND CAST(r.DatedOn AS DATE) = @dateOn  -- So sánh DatedOn đã được ép kiểu với @dateOn
    -- Có thể lọc thêm status nếu cần, ví dụ:
    -- AND (r.Status = 0 OR r.Status = 1)  -- Cho phép cả trạng thái đã được xử lý (1) và chưa xử lý (0)
END

-- lấy về những reservation mà của cái chi nhánh đó trong ngày đó

go


drop index  IX_Orders_ReservationId on ORDERs

DECLARE @StartTime DATETIME = GETDATE();

-- Thực thi truy vấn của bạn
EXEC getDetailReservationCards @branchId = 'be17a130-0581-4315-bb2b-070f26292fbd', @dateOn = '2024-1-30'

DECLARE @EndTime DATETIME = GETDATE();

-- Tính toán và hiển thị thời gian thực thi
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS ExecutionTimeMs;

EXEC getOrderDetailsByReservationId @reservationId = 'f9f51d72-39d5-4adb-8adc-04a9c74487a6';



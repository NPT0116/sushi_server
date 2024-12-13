-- use sushiDB;
-- go
-- CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
--     @BranchId UNIQUEIDENTIFIER,
--     @StartDate DATE,
--     @EndDate DATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--         -- Kiểm tra xem có tồn tại Branch với BranchId đã cho không
--         IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId)
--         BEGIN
--             RAISERROR('BranchId does not exist.', 16, 1);
--             RETURN;
--         END

--         -- Truy vấn doanh thu theo ngày cho BranchId trong khoảng thời gian từ @StartDate đến @EndDate
--         SELECT 
--             CAST(i.DatedOn AS DATE) AS RevenueDate,  -- Chỉ lấy ngày
--             SUM(i.AfterDiscount) AS TotalRevenue
--         FROM 
--             Invoices i
--         JOIN 
--             Orders o ON o.Id = i.OrderId
--         JOIN 
--             Reservation r ON r.Id = o.ReservationId
--         WHERE 
--             i.Paid = 1  -- Hóa đơn đã thanh toán
--             AND r.BranchId = @BranchId  -- Lọc theo BranchId
--             AND CAST(i.DatedOn AS DATE) >= @StartDate  -- Lọc từ ngày bắt đầu
--             AND CAST(i.DatedOn AS DATE) <= @EndDate  -- L
--         GROUP BY 
--             CAST(i.DatedOn AS DATE)  -- Nhóm theo ngày
--         ORDER BY 
--             RevenueDate;


-- END;
use sushiDB;
go
CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
    @BranchId UNIQUEIDENTIFIER,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

        -- Truy vấn doanh thu theo ngày cho BranchId trong khoảng thời gian từ @StartDate đến @EndDate
        SELECT 
            CAST(i.DatedOn AS DATE) AS RevenueDate,  -- Chỉ lấy ngày
            SUM(i.AfterDiscount) AS TotalRevenue
        FROM 
            Invoices i
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND BranchId = @BranchId  -- Lọc theo BranchId
            AND CAST(i.DatedOn AS DATE) >= @StartDate  -- Lọc từ ngày bắt đầu
            AND CAST(i.DatedOn AS DATE) <= @EndDate  -- L
        GROUP BY 
            i.DatedOn 
        ORDER BY 
            i.DatedOn
END;

DECLARE @StartTime DATETIME2 = SYSDATETIME();

-- Thực thi truy vấn của bạn
EXEC GetRevenueByDateRangeForBranch @BranchId = '40b52a5a-4a5f-4f28-addc-fc03b2e1d1f8', @StartDate = '2024-1-1', @EndDate = '2024-12-30';

DECLARE @EndTime DATETIME2 = SYSDATETIME();

-- Tính toán và hiển thị thời gian thực thi
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS ExecutionTimeMs;



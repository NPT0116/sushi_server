-- use sushiDB;
-- go
-- CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
--     @BranchId UNIQUEIDENTIFIER,
--     @StartDate DATE,
--     @EndDate DATE
-- AS
-- BEGIN


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

--after
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
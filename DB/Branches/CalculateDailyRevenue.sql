-- Before hạ chuẩn
CREATE OR ALTER PROCEDURE GetDailyRevenueByBranch
    @BranchId UNIQUEIDENTIFIER,
    @Date DATE
AS
BEGIN
    SET NOCOUNT ON;

        -- Tính tổng doanh thu trong ngày của BranchId thông qua Reservation
        SELECT 
            SUM(CAST(i.AfterDiscount AS BIGINT)) AS TotalRevenue        FROM 
            Invoices i
        JOIN 
            Orders o ON o.Id = i.OrderId
        JOIN 
            Reservation r ON r.Id = o.ReservationId -- Thêm join với Reservation
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND r.BranchId = @BranchId  -- Kiểm tra BranchId từ Reservation
            AND CAST(i.DatedOn AS DATE) = @Date  -- Lọc theo ngày
        GROUP BY 
            r.BranchId;

END;
go
-- after hạ chuẩn 
CREATE OR ALTER PROCEDURE GetDailyRevenueByBranch
    @BranchId UNIQUEIDENTIFIER,
    @Date DATE
AS
BEGIN
    SET NOCOUNT ON;

        -- Tính tổng doanh thu trong ngày của BranchId thông qua Reservation
        SELECT 
            SUM(CAST(i.AfterDiscount AS BIGINT)) AS TotalRevenue        FROM 
            Invoices i
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND BranchId = @BranchId  -- Kiểm tra BranchId từ Reservation
            AND CAST(i.DatedOn AS DATE) = @Date  -- Lọc theo ngày
        GROUP BY 
            BranchId;

END;


-- kết hợp index

GO
CREATE NONCLUSTERED INDEX [IDX_Invoices_Paid_BranchId_DatedOn]
ON [dbo].[Invoices] ([Paid],[BranchId],[DatedOn])
INCLUDE ([AfterDiscount])
GO



drop index [<Name of Missing Index, sysname,>] on invoices

SELECT top 15 * from Branches

exec GetDailyRevenueByBranch @BranchId = 'ee20af0b-df4b-43c4-b721-917904c7188d', @Date = '2024-1-30'

select * from Invoices


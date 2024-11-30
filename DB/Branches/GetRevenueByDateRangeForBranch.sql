use sushiDB;
go
CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
    @BranchId UNIQUEIDENTIFIER,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem có tồn tại Branch với BranchId đã cho không
        IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId)
        BEGIN
            RAISERROR('BranchId does not exist.', 16, 1);
            RETURN;
        END

        -- Truy vấn doanh thu theo ngày cho BranchId trong khoảng thời gian từ @StartDate đến @EndDate
        SELECT 
            CAST(i.DatedOn AS DATE) AS RevenueDate,  -- Chỉ lấy ngày
            SUM(i.AfterDiscount) AS TotalRevenue
        FROM 
            Invoices i
        JOIN 
            Orders o ON o.Id = i.OrderId
        JOIN 
            Reservation r ON r.Id = o.ReservationId
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND r.BranchId = @BranchId  -- Lọc theo BranchId
            AND CAST(i.DatedOn AS DATE) >= @StartDate  -- Lọc từ ngày bắt đầu
            AND CAST(i.DatedOn AS DATE) <= @EndDate  -- L
        GROUP BY 
            CAST(i.DatedOn AS DATE)  -- Nhóm theo ngày
        ORDER BY 
            RevenueDate;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;



exec GetRevenueByDateRangeForBranch @BranchId = 'd1cc887e-7bb0-48e4-8874-2d6a7aa7f6b8', @StartDate = '2024-11-1', @EndDate = '2024-11-30'

select * from Reservation


SELECT COUNT(*) FROM Reservation;

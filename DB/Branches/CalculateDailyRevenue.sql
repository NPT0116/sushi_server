CREATE OR ALTER PROCEDURE GetDailyRevenueByBranch
    @BranchId UNIQUEIDENTIFIER,
    @Date DATE
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

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

SELECT top 1 * from Branches

exec GetDailyRevenueByBranch @BranchId = 'e69eff34-6b46-4036-9db9-0b66ed24339e', @Date = '2024-1-30'

select * from Invoices


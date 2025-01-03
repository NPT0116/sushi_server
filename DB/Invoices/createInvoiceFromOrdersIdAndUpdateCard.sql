CREATE OR ALTER PROCEDURE CreateInvoiceAndUpdateCustomerCard
    @OrderId UNIQUEIDENTIFIER,
    @paymentMethod NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu hóa đơn đã tồn tại cho OrderId
    IF EXISTS (SELECT 1 FROM Orders o JOIN Invoices i ON i.OrderId = o.Id WHERE o.Id = @OrderId)
    BEGIN
        RAISERROR('Invoice for this order already exists', 16, 1);
        RETURN;
    END

    -- Khai báo biến
    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @Total BIGINT;
    DECLARE @AfterDiscount BIGINT;
    DECLARE @InvoiceId UNIQUEIDENTIFIER;
    DECLARE @bonusPoint INT;
    DECLARE @Discount INT;
    DECLARE @ReservationDate DATE;  -- Biến lưu trữ ngày đặt chỗ (DatedOn từ Reservation)
    DECLARE @ReservationId UNIQUEIDENTIFIER;  -- Biến lưu trữ ReservationId
    DECLARE @TableId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation
    DECLARE @BranchId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation

    -- 1. Lấy thông tin từ bảng Orders và Reservation
    SELECT 
        @CustomerId = r.CustomerId,
        @Total = o.Total,
        @ReservationDate = r.DatedOn,  -- Lấy ngày đặt chỗ từ Reservation
        @ReservationId = r.Id,         -- Lấy ReservationId
        @TableId = r.TableId,
        @BranchId = r.BranchId           -- Lấy TableId từ Reservation
    FROM Orders o
    JOIN Reservation r ON r.Id = o.ReservationId
    WHERE o.Id = @OrderId;

    -- Kiểm tra nếu không tìm thấy đơn hàng
    IF @CustomerId IS NULL
    BEGIN
        RAISERROR('OrderId không tồn tại hoặc không tìm thấy khách hàng', 16, 1);
        RETURN;
    END

    -- 2. Kiểm tra sự tồn tại của thẻ khách hàng và tính toán giảm giá
    IF NOT EXISTS (SELECT 1 FROM Cards c WHERE c.CustomerId = @CustomerId)
    BEGIN
        -- Nếu không có thẻ, gán Discount = 0
        SET @Discount = 0;
    END
    ELSE
    BEGIN
        -- Lấy thông tin giảm giá từ bảng Cards và Rankings nếu khách hàng có thẻ
        SELECT @Discount = r.Discount
        FROM Cards c
        JOIN Rankings r ON c.RankingId = r.Id
        WHERE c.CustomerId = @CustomerId;
    END

    -- 3. Tính toán giá trị AfterDiscount
    SET @AfterDiscount = (100 - @Discount) / 100.0 * @Total;

    -- 4. Tính điểm thưởng
    SET @bonusPoint = FLOOR(@AfterDiscount / 100000);  -- Quy đổi 100.000 VND = 1 điểm
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId and Valid = 1)
    BEGIN
        -- Cập nhật thẻ khách hàng
        UPDATE Cards
        SET AccumulatedPoints = AccumulatedPoints + @bonusPoint
        WHERE CustomerId = @CustomerId and Valid = 1;
    END
    ELSE
    BEGIN
    SET @bonusPoint = 0
    END
    -- 5. Tạo hóa đơn mới trong bảng Invoices
    SET @InvoiceId = NEWID();  -- Tạo InvoiceId mới

    INSERT INTO Invoices (Id, OrderId, DatedOn, Total, PaymentMethod, Paid, AfterDiscount, BonusPoint, BranchId)
    VALUES (@InvoiceId, @OrderId, @ReservationDate, @Total, @paymentMethod, 0, @AfterDiscount, @bonusPoint, @BranchId);  -- Sử dụng @ReservationDate thay vì GETDATE()

    -- 6. Cập nhật điểm số cho thẻ khách hàng


    -- 7. Cập nhật trạng thái đơn hàng thành "Invoiced"
    UPDATE Orders
    SET Status = 2
    WHERE Id = @OrderId;

    -- 8. Cập nhật lại Reservation, đặt TableId thành NULL
    UPDATE Reservation
    SET  Status = 2  -- Cập nhật trạng thái thành "In Progress" và TableId thành NULL
    WHERE Id = @ReservationId;

    -- 9. Cập nhật lại TableDetail, đặt trạng thái của bàn về trạng thái "available" hoặc "vacant"
    UPDATE TableDetail
    SET Status = 0  -- Giả sử '1' là trạng thái "available" hoặc "vacant"
    WHERE TableId = @TableId;

    -- 10. Trả về thông tin hóa đơn mới tạo
    SELECT 
        CAST(Id AS UNIQUEIDENTIFIER) AS Id,
        CAST(OrderId AS UNIQUEIDENTIFIER) AS OrderId,
        CAST(DatedOn AS DATETIME2) AS DatedOn,
        CAST(Total AS BIGINT) AS Total,
        CAST(PaymentMethod AS NVARCHAR(MAX)) AS PaymentMethod,
        CAST(Paid AS BIT) AS Paid,
        CAST(AfterDiscount AS BIGINT) AS AfterDiscount,
        CAST(BonusPoint AS INT) AS BonusPoint,
        CAST(BranchId AS UNIQUEIDENTIFIER) AS BranchId
    FROM Invoices 
    WHERE Id = @InvoiceId;
    
END;



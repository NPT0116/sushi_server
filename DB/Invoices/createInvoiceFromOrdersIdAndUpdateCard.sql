CREATE OR ALTER PROCEDURE CreateInvoiceAndUpdateCustomerCard
    @OrderId UNIQUEIDENTIFIER,
    @paymentMethod NVARCHAR(50)
AS
BEGIN
    if exists ( select 1 from Orders o join Invoices i on i.OrderId = o.Id where o.Id = @OrderId)
    BEGIN
    RAISERROR('Invoices for this order already exists',16,1);
    RETURN;
    END
    -- Khai báo biến
    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @Total DECIMAL(18, 2);
    DECLARE @AfterDiscount DECIMAL(18, 2);
    DECLARE @InvoiceId UNIQUEIDENTIFIER;
    DECLARE @bonusPoint INT;
    DECLARE @Discount INT;

    -- 1. Lấy thông tin từ bảng Orders và Reservation
    SELECT 
        @CustomerId = r.CustomerId,
        @Total = o.Total
    FROM Orders o
    JOIN Reservation r ON r.Id = o.ReservationId
    WHERE o.Id = @OrderId;

    -- Kiểm tra nếu không tìm thấy đơn hàng
    IF @CustomerId IS NULL
    BEGIN
        RAISERROR('OrderId không tồn tại hoặc không tìm thấy khách hàng', 16, 1);
        RETURN;
    END

    -- 2. Lấy thông tin giảm giá từ bảng Cards và Rankings
    SELECT @Discount = r.Discount
    FROM Cards c
    JOIN Rankings r ON c.RankingId = r.Id
    WHERE c.CustomerId = @CustomerId;

    -- 3. Tính toán giá trị AfterDiscount
    SET @AfterDiscount = (100 - @Discount) / 100.0 * @Total;

    -- 4. Tính điểm thưởng
    SET @bonusPoint = FLOOR(@AfterDiscount / 100);

    -- 5. Tạo hóa đơn mới trong bảng Invoices
    SET @InvoiceId = NEWID();  -- Tạo InvoiceId mới

    INSERT INTO Invoices (Id, OrderId, DatedOn, Total, PaymentMethod, Paid, AfterDiscount, BonusPoint)
    VALUES (@InvoiceId, @OrderId, GETDATE(), @Total, @paymentMethod, 0, @AfterDiscount, @bonusPoint);

    -- 6. Cập nhật điểm số cho thẻ khách hàng
    -- Kiểm tra xem khách hàng đã có thẻ chưa
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId)
    BEGIN
        -- Cập nhật thẻ khách hàng
        UPDATE Cards
        SET AccumulatedPoints = AccumulatedPoints + @bonusPoint
        WHERE CustomerId = @CustomerId;
    END

    -- 7. Cập nhật trạng thái đơn hàng thành "Invoiced"
    UPDATE Orders
    SET Status = 2
    WHERE Id = @OrderId;

    -- 8. Trả về thông tin hóa đơn mới tạo
    SELECT * FROM Invoices WHERE Id = @InvoiceId;
END;


EXEC CreateInvoiceAndUpdateCustomerCard @OrderId ='adde16b9-648a-49e5-a1cd-0031078d71e7', @paymentMethod = 'Cash'

select * from Invoices
select * from Orders
delete from Invoices 
where OrderId = 'adde16b9-648a-49e5-a1cd-0031078d71e7' 

select * from cards
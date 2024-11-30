USE sushiDB;
GO

DECLARE @OrderId1 UNIQUEIDENTIFIER;

-- Lấy tất cả OrderId từ bảng Orders
DECLARE OrderCursor CURSOR FOR 
SELECT o.Id FROM Orders o  WHERE Status = 2  ;  -- Chỉ lấy các Order chưa có hóa đơn (Status = 1)

OPEN OrderCursor;

FETCH NEXT FROM OrderCursor INTO @OrderId1;

-- Lặp qua tất cả các OrderId để tạo Invoice
WHILE @@FETCH_STATUS = 0
BEGIN
    -- In OrderId đang xử lý
    -- Gọi stored procedure CreateInvoiceAndUpdateCustomerCard với mỗi OrderId
    EXEC CreateInvoiceAndUpdateCustomerCard @OrderId = @OrderId1, @paymentMethod = 'cash';

    FETCH NEXT FROM OrderCursor INTO @OrderId1;
END

CLOSE OrderCursor;
DEALLOCATE OrderCursor;

GO

-- Kiểm tra kết quả, kiểm tra bảng Invoices sau khi tạo



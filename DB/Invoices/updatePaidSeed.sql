DECLARE @InvoiceId UNIQUEIDENTIFIER;

DECLARE InvoiceCursor CURSOR FOR 
SELECT Id FROM Invoices WHERE Paid = 0;  -- Chỉ lấy các hóa đơn chưa thanh toán

OPEN InvoiceCursor;

FETCH NEXT FROM InvoiceCursor INTO @InvoiceId;

-- Lặp qua tất cả các InvoiceId để cập nhật Paid thành 1
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Gọi stored procedure UpdatePaidInvoice với mỗi InvoiceId chưa thanh toán
    EXEC UpdatePaidInvoice @InvoiceId = @InvoiceId;

    FETCH NEXT FROM InvoiceCursor INTO @InvoiceId;
END

CLOSE InvoiceCursor;
DEALLOCATE InvoiceCursor;

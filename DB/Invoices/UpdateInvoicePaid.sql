

CREATE OR ALTER PROCEDURE UpdatePaidInvoice
    @InvoiceId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem hóa đơn có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM Invoices WHERE Id = @InvoiceId)
        BEGIN
            RAISERROR('Invoice not found.', 16, 1);
            RETURN;
        END

        -- Cập nhật trường Paid thành 1 (đã thanh toán)
        UPDATE Invoices
        SET Paid = 1
        WHERE Id = @InvoiceId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

select top 1 * from Invoices
EXEC UpdatePaidInvoice @InvoiceId = 'd554e665-0354-4b78-97ee-07a5ed6f3ec5'

update Invoices
set paid = 0
where id = 'd554e665-0354-4b78-97ee-07a5ed6f3ec5'
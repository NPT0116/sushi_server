USE sushiDB;
GO

CREATE OR ALTER PROCEDURE GetLatestInvoicesByOrder
    @OrderId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 5
        i.Id,
        i.Total,
        i.PaymentMethod,
        i.AfterDiscount,
        i.BonusPoint,
        i.Paid,
        i.DatedOn,
        i.OrderId,
        i.BranchId
    FROM Invoices i
    WHERE i.OrderId = @OrderId
    ORDER BY i.DatedOn DESC;
END;
GO

select * from Orders
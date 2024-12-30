USE sushiDB;
GO

CREATE OR ALTER PROCEDURE GetLatestInvoicesByCustomer
    @CustomerId UNIQUEIDENTIFIER
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
    join orders o on o.Id = i.OrderId 
    JOIN Reservation r on o.ReservationId = r.Id 
    WHERE r.CustomerId = @CustomerId and i.Paid = 1
    ORDER BY i.DatedOn DESC;
END;
GO
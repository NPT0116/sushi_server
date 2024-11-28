-- 4 Xuất hóa đơn -> update đơn hàng hoàn thành -> sync after_discount -> sync bonus point -> update bonus point for customer card -> checkout reservation
CREATE OR ALTER TRIGGER create_invoice ON Invoices
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		-- Update order status
		UPDATE Orders
		SET Status = 2
		WHERE Id IN (SELECT OrderId FROM inserted);

		-- Calculate discount
		DECLARE @Discount INT;
		SELECT @Discount = ra.Discount
		FROM Orders o
		JOIN Reservation r ON o.ReservationId = r.Id
		JOIN Cards ca ON r.CustomerId = ca.CustomerId
		JOIN Rankings ra ON ca.RankingId = ra.Id
		WHERE ca.Valid = 1
		  AND o.Id IN (SELECT OrderId FROM inserted);

		-- Update invoice totals
		UPDATE Invoices
		SET Total = o.Total,
			AfterDiscount = o.Total * (100 - @Discount) / 100
		FROM Invoices i
		JOIN Orders o ON o.Id = i.OrderId
		WHERE i.Id IN (SELECT Id FROM inserted);
	
		-- Update bonus points
		UPDATE Invoices
		SET BonusPoint = ROUND(AfterDiscount / 100000, 2)
		WHERE Id IN (SELECT Id FROM inserted);

		-- Update customer card points
		UPDATE Cards
		SET AccumulatedPoints = AccumulatedPoints + i.BonusPoint
		FROM Cards c
		JOIN Reservation r ON r.CustomerId = c.CustomerId
		JOIN Orders o ON o.ReservationId = r.Id
		JOIN Invoices i ON o.Id = i.OrderId
		WHERE c.Valid = 1
		  AND i.Id IN (SELECT Id FROM inserted);

		-- Checkout reservation
		DECLARE @reservation_id UNIQUEIDENTIFIER;
		SELECT TOP 1 @reservation_id = o.ReservationId
		FROM inserted i
		JOIN orders o ON o.id = i.OrderId;
		EXEC check_out_reservation @reservation_id;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;

		THROW;
	END CATCH;
END;
GO

-- Invoice invoice = new Invoice {
            --     PaymentMethod = paymentMethod,
            --     Order = order,
            --     DatedOn = DateTime.Now,
            --     Paid = false,
            --     Total = order.Total,
            -- };
insert into invoices (id, PaymentMethod, OrderId, DatedOn, paid) values (
    newid(),
    'cash',
    '3973572A-C307-4BE9-AB88-003C50C2BF38',
    GETDATE(),
    0)

delete from invoices;
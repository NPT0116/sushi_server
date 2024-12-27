use sushiDb
go

-- This stored procedure retrieves invoices for a specific branch and date range.
CREATE OR ALTER PROCEDURE QueryInvoicesByBranchAndDate
    @BranchId UNIQUEIDENTIFIER NULL,
    @StartDate DATETIME,
    @EndDate DATETIME,
    @CustomerName NVARCHAR(255) NULL
AS
BEGIN
    SELECT *
    FROM Invoices i
    join Customers c on c.CustomerId = i.CustomerId
    WHERE (@BranchId IS NULL OR i.BranchId = @BranchId)
    AND (@CustomerName is NULL OR @CustomerName = c.Name)
    AND (i.DatedOn BETWEEN @StartDate AND @EndDate)
END

exec QueryInvoicesByBranchAndDate '715e0933-fea9-41f6-a45a-10bc569ccc94', '2024-10-13', '2024-10-20', 'Arch Swalteridge'

ALTER TABLE [dbo].[Invoices]
ADD [CustomerId] UNIQUEIDENTIFIER NULL
GO

UPDATE i
SET i.CustomerId = r.CustomerId
FROM [dbo].[Invoices] i
JOIN [dbo].[Orders] o ON o.Id = i.OrderId
JOIN [dbo].[Reservation] r ON r.Id = o.ReservationId
JOIN [dbo].[Customers] c ON c.CustomerId = r.CustomerId;
GO

ALTER TABLE [dbo].[Invoices]
ADD CONSTRAINT [FK_Invoices_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId]);
GO

exec getDetailReservationCards '715e0933-fea9-41f6-a45a-10bc569ccc94', '2024-12-23'

select top 1 * from Invoices ORDER by DatedOn DESC
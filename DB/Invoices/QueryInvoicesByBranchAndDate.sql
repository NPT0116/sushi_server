use sushiDB
go

CREATE PARTITION FUNCTION partition_by_month (DATETIME2(7))
AS RANGE LEFT FOR VALUES 
    ('2024-01-31T23:59:59.9999999', '2024-02-29T23:59:59.9999999', 
     '2024-03-31T23:59:59.9999999', '2024-04-30T23:59:59.9999999',
     '2024-05-31T23:59:59.9999999', '2024-06-30T23:59:59.9999999', 
     '2024-07-31T23:59:59.9999999', '2024-08-31T23:59:59.9999999', 
     '2024-09-30T23:59:59.9999999', '2024-10-31T23:59:59.9999999', 
     '2024-11-30T23:59:59.9999999', '2024-12-31T23:59:59.9999999');

    ALTER DATABASE sushiDB
ADD FILEGROUP January;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP February;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP March;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP April;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP May;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP June;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP July;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP August;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP September;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP October;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP November;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP December;
GO

ALTER DATABASE sushiDB
ADD FILEGROUP After_2024;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = January,
    FILENAME = 'D:\data\January.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP January;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = February,
    FILENAME = 'D:\data\February.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP February;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = March,
    FILENAME = 'D:\data\March.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP March;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = April,
    FILENAME = 'D:\data\April.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP April;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = May,
    FILENAME = 'D:\data\May.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP May;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = June,
    FILENAME = 'D:\data\June.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP June;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = July,
    FILENAME = 'D:\data\July.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP July;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = August,
    FILENAME = 'D:\data\August.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP August;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = September,
    FILENAME = 'D:\data\September.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP September;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = October,
    FILENAME = 'D:\data\October.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP October;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = November,
    FILENAME = 'D:\data\November.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP November;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = December,
    FILENAME = 'D:\data\December.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP December;
GO

ALTER DATABASE sushiDB    
ADD FILE (
    NAME = After_2024,
    FILENAME = 'D:\data\After_2024.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP After_2024;
GO

SELECT 
	name as filename,
	physical_name as file_path
FROM sys.database_files
where type_desc = 'ROWS';

CREATE PARTITION SCHEME month_scheme_2
AS PARTITION partition_by_month
TO ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December], [After_2024]);
GO

CREATE TABLE [dbo].[Invoices_Partition_2] (
    [Id]            UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Total]         BIGINT           NOT NULL,
    [PaymentMethod] NVARCHAR (MAX)   NOT NULL,
    [AfterDiscount] INT              NOT NULL,
    [BonusPoint]    INT              NOT NULL,
    [Paid]          BIT              NOT NULL,
    [DatedOn]       DATETIME2 (7)    NOT NULL,
    [OrderId]       UNIQUEIDENTIFIER NOT NULL,
    [BranchId]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Invoices_Partition_2] PRIMARY KEY ([Id] , [DatedOn]),
    CONSTRAINT [FK_Invoices_Partition_2_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([Id]) ,
    CONSTRAINT [FK_Invoices_Partition_2_Branch_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branches] ([BranchId])
) ON month_scheme_2 (DatedOn);
go

CREATE OR ALTER PROCEDURE QueryInvoicesByBranchAndDateWithPartition2
    @BranchId UNIQUEIDENTIFIER NULL,
    @StartDate DATETIME2 (7),
    @EndDate DATETIME2 (7),
    @Phone NVARCHAR(20) NULL
AS
BEGIN
    SELECT i.Id, i.Total, i.PaymentMethod, i.AfterDiscount, i.BonusPoint, i.Paid, i.DatedOn, c.Name, c.Phone
    FROM Invoices_Partition_2 i
	join Orders o on o.Id = i.OrderId
	join Reservation r on r.Id = o.ReservationId
    join Customers c on c.CustomerId = r.CustomerId
    WHERE (@BranchId IS NULL OR i.BranchId = @BranchId)
    AND (@Phone is NULL OR @Phone = c.Phone)
    AND (i.DatedOn BETWEEN @StartDate AND @EndDate)
END

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
DECLARE @StartTime DATETIME, @EndTime DATETIME;
SET @StartTime = SYSDATETIME();
exec QueryInvoicesByBranchAndDateWithPartition2 'f920a9d0-4d96-4788-b74c-3a8c9b4c2ea1', '2024-01-01 00:00:00', '2024-01-31 00:00:00', NULL 
SET @EndTime = SYSDATETIME();

-- Hiển thị thời gian thực hiện
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS [Execution Time for Invoices];
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
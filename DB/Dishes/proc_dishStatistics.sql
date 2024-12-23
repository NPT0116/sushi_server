-- PROCEDURE
GO
CREATE OR ALTER PROCEDURE PD_DISH_STATISTICS
    @branchId UNIQUEIDENTIFIER,
    @startDate DATE,
    @endDate DATE,
    @mode INT
AS
BEGIN
    -- CHECKING
    IF @endDate < @startDate
    BEGIN
        RAISERROR('ERROR: Start-Date must be greater than End-Date', 16, 1)
        RETURN;
    END
    -- READ
    -- RETURN TOP 5 BEST SALER
    IF @mode = 1
    BEGIN
        SELECT TOP 5 D.DishName, COUNT(I.Id) AS TotalOrders
        FROM Invoices I
            JOIN Orders O ON O.Id = I.OrderId
            JOIN OrderDetail OD ON OD.OrderId = O.Id
            JOIN Dishes D ON D.DishId = OD.DishId
        WHERE @startDate <= CONVERT(DATE, I.DatedOn) AND CONVERT(DATE, I.DatedOn) <= @endDate AND I.BranchId = @branchId
        GROUP BY D.DishID, D.DishName
        ORDER BY TotalOrders DESC
    END
    -- RETURN TOP 5 WORST SALER
    IF @mode = 2
    BEGIN
        SELECT TOP 5 D.DishName, COUNT(I.Id) AS TotalOrders
        FROM Invoices I
            JOIN Orders O ON O.Id = I.OrderId
            JOIN OrderDetail OD ON OD.OrderId = O.Id
            JOIN Dishes D ON D.DishId = OD.DishId
        WHERE @startDate <= CONVERT(DATE, I.DatedOn) AND CONVERT(DATE, I.DatedOn) <= @endDate AND I.BranchId = @branchId
        GROUP BY D.DishID, D.DishName
        ORDER BY TotalOrders ASC
    END
END




-- TOP 5 BEST SELLER
GO
GO
-- TOP 5 WORST SELLER
GO
    EXEC PD_DISH_STATISTICS 'c70fcfb6-855b-4d3e-b81b-032af3393c72', '2024-02-01', '2024-02-28', 2
GO

-- Enable statistics time and IO
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- Execute your query
    EXEC PD_DISH_STATISTICS 'c70fcfb6-855b-4d3e-b81b-032af3393c72', '2024-02-01', '2024-02-28', 2

-- Disable statistics time and IO
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

SELECT 
	name AS IndexName, 
	type_desc AS IndexType, 
	is_unique AS IsUnique
FROM sys.indexes
WHERE object_id = OBJECT_ID('dbo.OrderDetail');
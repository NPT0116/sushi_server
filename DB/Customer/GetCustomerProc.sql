USE sushiDB;
GO

CREATE OR ALTER PROCEDURE getCustomersWithSingleActiveCard
    @PageNumber INT,
    @PageSize INT,
    @PhoneNumber NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH CustomerCTE AS (
        SELECT 
            c.CustomerId,
            c.Name,
            c.Phone,
            c.CitizenId,
            c.DateOfBirth,
            c.Email,
            c.Gender,
            cd.CardId,
            cd.AccumulatedPoints,
            cd.AccumulatedDate,
            cd.Valid,
            r.Name AS RankName,
            ROW_NUMBER() OVER (ORDER BY c.CustomerId) AS RowNum
        FROM Customers c
        JOIN Cards cd ON c.CustomerId = cd.CustomerId
        JOIN Rankings r ON cd.RankingId = r.Id
        WHERE cd.Valid = 1
        AND (@PhoneNumber IS NULL OR c.Phone = @PhoneNumber)
        GROUP BY c.CustomerId, c.Name, c.Phone, cd.CardId, cd.Valid, r.Name, c.CitizenId, c.Email, c.Gender, cd.CardId, cd.AccumulatedDate, cd.AccumulatedPoints, c.DateOfBirth
        HAVING COUNT(cd.CardId) = 1
    )
    SELECT *
    FROM CustomerCTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize;
END;
GO
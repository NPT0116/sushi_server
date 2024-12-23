USE sushiDB;
GO

CREATE OR ALTER PROCEDURE getCustomersWithSingleActiveCard
    @PageNumber INT,
    @PageSize INT,
    @PhoneNumber NVARCHAR(20) = NULL,
    @TotalRecord INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the total number of records
    SELECT @TotalRecord = COUNT(*)
    FROM Customers c
    LEFT JOIN Cards cd ON c.CustomerId = cd.CustomerId
    WHERE (@PhoneNumber IS NULL OR c.Phone LIKE @PhoneNumber + '%');

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
        LEFT JOIN Cards cd ON c.CustomerId = cd.CustomerId AND cd.Valid = 1
        LEFT JOIN Rankings r ON cd.RankingId = r.Id
        WHERE (@PhoneNumber IS NULL OR c.Phone LIKE @PhoneNumber + '%')
        GROUP BY c.CustomerId, c.Name, c.Phone, cd.CardId, cd.Valid, r.Name, c.CitizenId, c.Email, c.Gender, cd.CardId, cd.AccumulatedDate, cd.AccumulatedPoints, c.DateOfBirth
    )
    SELECT *
    FROM CustomerCTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize;
END;
GO




DECLARE @out INT
EXEC getCustomersWithSingleActiveCard 1, 10, @TotalRecord = @out out, @PhoneNumber = '0915361071';

print @out



select * from Account
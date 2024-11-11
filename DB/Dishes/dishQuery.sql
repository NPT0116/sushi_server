USE sushiDB;


GO
--Get all Procedure

CREATE OR ALTER PROCEDURE GetAllDishes
    @DishName NVARCHAR(50) = NULL,
    @MinPrice INT = NULL,
    @MaxPrice INT = NULL,
    @PageNumber INT = NULL,
    @PageSize INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu PageNumber hoặc PageSize NULL, thì trả về toàn bộ kết quả
    IF @PageNumber IS NULL OR @PageSize IS NULL
    BEGIN
        SELECT DishId, DishName, CurrentPrice, SectionId
        FROM Dishes
        WHERE (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
        ORDER BY DishName;

        -- Tổng số bản ghi cho pagination
        SELECT COUNT(1) AS TotalRecords
        FROM Dishes
        WHERE (@DishName IS NULL OR DishName LIKE '%' + @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice);
    END
    ELSE
    BEGIN
        -- Có phân trang
        SELECT DishId, DishName, CurrentPrice, SectionId
        FROM Dishes
        WHERE (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
        ORDER BY DishName
        OFFSET (@PageNumber - 1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        -- Tổng số bản ghi cho pagination
        SELECT COUNT(1) AS TotalRecords
        FROM Dishes
        WHERE (@DishName IS NULL OR DishName LIKE '%' + @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice);
    END
END;



Go

CREATE OR ALTER PROCEDURE GetDishesBySectionId
	@SectionId UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	SELECT d.DishId,d.DishName, d.CurrentPrice, SectionId from Dishes d where SectionId = @SectionId
	Order by d.DishName
END

GO

EXEC GetDishesBySectionId @SectionId = 'e518919a-5662-40c5-8468-ae4a3ce70a80';

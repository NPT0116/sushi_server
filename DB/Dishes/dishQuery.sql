USE sushiDB;

GO
--Get all Procedure

CREATE OR ALTER PROCEDURE GetAllDishes
    @DishName NVARCHAR(50) = NULL,
    @MinPrice INT = NULL,
    @MaxPrice INT = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 10,
    @SectionId UNIQUEIDENTIFIER = NULL,
    @BranchId UNIQUEIDENTIFIER = NULL,
    @TotalRecords INT OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu PageNumber hoặc PageSize NULL, thì trả về toàn bộ kết quả
    BEGIN
        -- Có phân trang
        SELECT distinct d.DishId, DishName, CurrentPrice, SectionId
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE (@BranchId is null or (bd.BranchId = @BranchId and bd.[Status] = 1)) and (@SectionId is null or @SectionId = d.SectionId) and (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
        ORDER BY DishName 
        OFFSET (@PageNumber - 1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        SELECT  @TotalRecords = count(distinct d.DishId) 
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE (@BranchId is null or (bd.BranchId = @BranchId and bd.[Status] = 1)) and (@SectionId is null or @SectionId = d.SectionId) and (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
    END
END;


DECLARE @result int;
EXEC GetAllDishes @DishName  = a, @TotalRecords = @result OUT;

print(@result)
GO
DECLARE @DishName NVARCHAR(50);
DECLARE @TotalRecords int;
set @DishName = 'a';

        SELECT  d.DishName
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE     DishName LIKE @DishName + '%'
print(@TotalRecords)
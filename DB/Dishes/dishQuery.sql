USE sushiDB;

GO
--Get all Procedure

CREATE OR ALTER PROCEDURE GetAllDishes
    @DishName NVARCHAR(50) = NULL,
    @MinPrice INT = NULL,
    @MaxPrice INT = NULL,
    @PageNumber INT = NULL,
    @PageSize INT = NULL,
    @SectionId UNIQUEIDENTIFIER = NULL,
    @BranchId UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu PageNumber hoặc PageSize NULL, thì trả về toàn bộ kết quả
    BEGIN
        -- Có phân trang
        SELECT d.DishId, DishName, CurrentPrice, SectionId
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE (@BranchId is null or (bd.BranchId = @BranchId and bd.[Status] = 1)) and (@SectionId is null or @SectionId = d.SectionId) and (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
        ORDER BY DishName
        OFFSET (@PageNumber - 1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        SELECT COUNT(1) AS TotalRecords
        FROM Dishes
        WHERE (@DishName IS NULL OR DishName LIKE '%' + @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice);
    END
END;

EXEC GetAllDishes @DishName = 'c' , @PageNumber = 1 , @PageSize = 3, @BranchId = 'c2e09f53-ab47-4c39-88a2-010d8a5c9e97', @SectionId ='c3f5d7b4-8f44-4bb0-abc8-654321fedcba';

select BranchId from Branches;
select * from Sections
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




select d.DishId, d.DishName, d.CurrentPrice, d.SectionId, BranchId
FROM BranchDishes bd JOIN Dishes d on d.DishId = bd.DishId 
WHERE  (bd.[Status]  = 1 ) AND (d.DishName LIKE 'c%' ) and (bd.BranchId = 'c2e09f53-ab47-4c39-88a2-010d8a5c9e97')
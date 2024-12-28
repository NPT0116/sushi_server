

GO
create or alter PROCEDURE getallemployees
    @BranchId UNIQUEIDENTIFIER = NULL, 
    @DepartmentId UNIQUEIDENTIFIER = NULL, 
    @Name NVARCHAR(50) = NULL,
  @PageNumber INT = 1,
    @PageSize INT = 10,
    @TotalRecord INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    Select e.Id, e.Name, e.Dob, e.Gender, e.Salary
    from Employees e 
    where (@BranchId is Null OR @BranchId = e.BranchId ) and (@DepartmentId is null or @DepartmentId = e.DepartmentId) AND
    (@Name is NULL or e.Name LIKE @Name + '%' )
    Order by Name
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT @TotalRecord = count(1) 
    from Employees e 
    where (@BranchId is Null OR @BranchId = e.BranchId ) and (@DepartmentId is null or @DepartmentId = e.DepartmentId) AND
    (@Name is NULL or e.Name LIKE @Name + '%' )
    
END 

GO


EXEC getallemployees 
    @BranchId = NULL, 
    @DepartmentId = NULL, 
    @Name = 'ai', 
    @PageNumber = 1, 
    @PageSize = 10, 
    @TotalRecord = @Output OUTPUT;

-- Display the output value
PRINT(@Output)

DBCC FREEPROCCACHE;

DECLARE @StartTime DATETIME2 = SYSDATETIME();
DECLARE @Output INT;

-- Thực thi truy vấn của bạn
EXEC getallemployees 
    @BranchId = NULL, 
    @DepartmentId = NULL, 
    @Name = '', 
    @PageNumber = 1, 
    @PageSize = 10, 
    @TotalRecord = @Output OUTPUT;
DECLARE @EndTime DATETIME2 = SYSDATETIME();

-- Tính toán và hiển thị thời gian thực thi
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS ExecutionTimeMs;

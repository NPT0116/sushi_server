use sushiDB;
go
CREATE OR ALTER PROCEDURE InsertEmployeesPerBranch
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BranchId UNIQUEIDENTIFIER;
    DECLARE @DepartmentId UNIQUEIDENTIFIER;
    DECLARE @EmployeeName NVARCHAR(50);
    DECLARE @Salary INT;
    DECLARE @Dob DATE;
    DECLARE @StartDate DATE;
    DECLARE @DepartmentCount INT;
    DECLARE @DepartmentIndex INT;

    -- Get the number of departments
    SELECT @DepartmentCount = COUNT(*) FROM Departments;

    -- Loop through each Branch
    DECLARE BranchCursor CURSOR FOR SELECT BranchId FROM Branches;
    OPEN BranchCursor;

    FETCH NEXT FROM BranchCursor INTO @BranchId;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @DepartmentIndex = 0; -- Start with the first department for each branch

        -- Insert 20 employees for the current branch
        DECLARE @EmployeeCounter INT = 1;
        WHILE @EmployeeCounter <= 20
        BEGIN
            -- Select Department in a round-robin fashion
            SELECT @DepartmentId = DepartmentId 
            FROM (SELECT DepartmentId, ROW_NUMBER() OVER (ORDER BY DepartmentId) AS RowNum FROM Departments) AS Dept
            WHERE Dept.RowNum = (@DepartmentIndex % @DepartmentCount) + 1;

            -- Generate random values for the new employee
            SET @EmployeeName = N'Employee_' + LEFT(NEWID(), 8);
            SET @Salary = (SELECT BaseSalary FROM Departments WHERE DepartmentId = @DepartmentId) 
                          + (ABS(CHECKSUM(NEWID())) % 5000); -- Random salary adjustment
            SET @Dob = DATEADD(YEAR, -20 - (ABS(CHECKSUM(NEWID())) % 20), GETDATE()); -- Random DOB between 20 and 40 years ago
            SET @StartDate = DATEADD(YEAR, -ABS(CHECKSUM(NEWID()) % 5), GETDATE()); -- Random start date within last 5 years

            -- Insert the employee
            INSERT INTO Employees (Id, Name, Dob, Gender, Salary, StartDate, DepartmentId, BranchId)
            VALUES (NEWID(), @EmployeeName, @Dob, N'Nam', @Salary, @StartDate, @DepartmentId, @BranchId);

            -- Move to the next department in round-robin
            SET @DepartmentIndex = @DepartmentIndex + 1;
            SET @EmployeeCounter = @EmployeeCounter + 1;
        END

        FETCH NEXT FROM BranchCursor INTO @BranchId;
    END

    CLOSE BranchCursor;
    DEALLOCATE BranchCursor;
END;


EXEC InsertEmployeesPerBranch;

SELECT * from Employees




-- Load JSON data into a temporary table



CREATE OR ALTER PROCEDURE InsertEmployees
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BranchId UNIQUEIDENTIFIER;
    DECLARE @DepartmentId UNIQUEIDENTIFIER;
    DECLARE @EmployeeName NVARCHAR(50);  -- Tên đầy đủ của nhân viên
    DECLARE @Salary INT;
    DECLARE @Dob DATE;
    DECLARE @StartDate DATE;
    DECLARE @DepartmentCount INT;
    DECLARE @DepartmentIndex INT;

    -- Get the number of departments (giả sử có 7 phòng ban trong hệ thống)
    SELECT @DepartmentCount = COUNT(*) FROM Departments;
    
    -- Ensure there are exactly 7 departments
    IF @DepartmentCount <> 7
    BEGIN
        RAISERROR('There must be exactly 7 departments', 16, 1);
        RETURN;
    END

    -- Loop through each Branch
    DECLARE BranchCursor CURSOR FOR SELECT BranchId FROM Branches;
    OPEN BranchCursor;

    FETCH NEXT FROM BranchCursor INTO @BranchId;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @DepartmentIndex = 0;  -- Start with the first department for each branch

        -- Insert 50 employees for the current branch, evenly distributing across departments
        DECLARE @EmployeeCounter INT = 1;
        WHILE @EmployeeCounter <= 50
        BEGIN
            -- Select Department in a round-robin fashion
            SELECT @DepartmentId = DepartmentId 
            FROM (SELECT DepartmentId, ROW_NUMBER() OVER (ORDER BY DepartmentId) AS RowNum 
                  FROM Departments) AS Dept
            WHERE Dept.RowNum = ((@DepartmentIndex % @DepartmentCount) + 1);

            -- Get the BaseSalary for the selected department
            SELECT @Salary = BaseSalary FROM Departments WHERE DepartmentId = @DepartmentId;

            -- Select a random employee name from the employeesName table
            SELECT TOP 1 @EmployeeName = name
            FROM employeesName
            ORDER BY NEWID();  -- Randomly select a name

            -- Generate random DOB and StartDate for the new employee
            SET @Dob = DATEADD(YEAR, -20 - (ABS(CHECKSUM(NEWID())) % 20), GETDATE()); -- Random DOB between 20 and 40 years ago
            SET @StartDate = DATEADD(YEAR, -ABS(CHECKSUM(NEWID()) % 5), GETDATE()); -- Random start date within last 5 years

            -- Insert the employee with the same salary for the same department
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


EXEC InsertEmployees
select * from Employees


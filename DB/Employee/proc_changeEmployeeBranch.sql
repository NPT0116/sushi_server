GO
CREATE OR ALTER PROCEDURE PD_CHANGE_EMPLOYEE_BRANCH
    @employeeID UNIQUEIDENTIFIER,
    @newBranchId UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @newStartDate DATE = CAST(GETDATE() AS DATE)
    -- A. CHECKING
    -- CHECK IF EMPLOYEE ID EXIST
    IF NOT EXISTS(
        SELECT E.Id FROM Employees E
        WHERE E.Id = @employeeID
    )
    BEGIN
        RAISERROR('ERROR: EmployeeID is wrong or not exists', 16, 1);
        RETURN;
    END
    -- CHECK IF EMPLOYEE ID STILL WORK OR NOT
    IF EXISTS(
        SELECT E.Id FROM Employees E
        WHERE E.Id = @employeeID AND E.ResignedDate IS NOT NULL
    )
    BEGIN
        RAISERROR('ERROR: Employee Resigned', 16, 1);
        RETURN;
    END
    -- CHECK IF BRANCH ID EXIST
    IF NOT EXISTS(
        SELECT B.BranchId
        FROM Branches B WHERE B.BranchId = @newBranchId
    )
    BEGIN
        RAISERROR('ERROR: BranchID not found', 16 ,1);
        RETURN;
    END
    -- CHECK IF NEW BRANCH IS OLD BRANCH OR NOT
    DECLARE @oldBranchId UNIQUEIDENTIFIER
    SELECT @oldBranchId = BranchId 
    FROM Employees E
    WHERE E.Id = @employeeID
    IF @oldBranchId = @newBranchId
    BEGIN   
        RAISERROR('ERROR: New-BranchID is the same as Old-BranchID', 16, 1);
        RETURN;
    END
    -- CHECK NEW-START-DATE MUST BE GREATER THAN OLD-START-DATE IN WORK HISTORY
    DECLARE @oldStartDate DATE
    SELECT TOP 1 @oldStartDate = WH.StartDate
    FROM WorkHistory WH
    WHERE WH.EmployeeId = @employeeID 
    ORDER BY StartDate DESC

    IF @oldStartDate > @newStartDate
    BEGIN
        RAISERROR('ERROR: New-Start-Date must be greater than old-Start-Date', 16, 1);
        RETURN;
    END
    -- SELECT @oldStartDate -- DEBUG

    -- B. UPDATING --
    -- UPDATE BranchId in Employees
    UPDATE Employees 
    SET BranchId = @newBranchId
    WHERE Id = @employeeID
    -- UPDATE WORKHISTORY, SET RESIGNDATE OF CURRENT WORKING BRANCH TO NEW START DATE
    UPDATE WorkHistory
    SET ResignDate = @newStartDate
    WHERE Id = (
        SELECT TOP 1 Id
        FROM WorkHistory
        WHERE EmployeeId = @employeeID
        ORDER BY StartDate DESC
    )
    -- INSERT INTO WORK HISTORY
    DECLARE @Id UNIQUEIDENTIFIER
    SET @Id = NEWID();

    DECLARE @currentDepartmentID UNIQUEIDENTIFIER
    SELECT @currentDepartmentID = DepartmentID
    FROM Employees E WHERE E.Id = @employeeID
    INSERT INTO WorkHistory (Id, EmployeeId, BranchId, StartDate, ResignDate, DepartmentID)
    VALUES (@Id, @employeeID, @newBranchId, @newStartDate, NULL, @currentDepartmentID)

    -- SUCCESSFULLY INSERT
    PRINT 'Employee branch updated successfully !'
END
GO

GO
EXEC PD_CHANGE_EMPLOYEE_BRANCH 'bedb82a4-51be-46ea-9589-3a2d3c223299', '6937f7e2-c604-47d2-94a2-35b9e583223b'
GO
 
-- SELECT * FROM Employees
-- WHERE Id = 'bedb82a4-51be-46ea-9589-3a2d3c223299'
-- DEBUG
-- EmployeeId '0b2e2cda-fe1a-4f6f-9093-012220f31358'
-- EmployeeId2 'bedb82a4-51be-46ea-9589-3a2d3c223299'
-- BranchId_1 '92c87bb4-62b0-464b-8103-9b5d63b2c64b'
-- BranchId_2 '6937f7e2-c604-47d2-94a2-35b9e583223b'
-- SELECT * FROM WorkHistory WH
-- WHERE WH.EmployeeId = '0b2e2cda-fe1a-4f6f-9093-012220f31358'
-- ORDER BY WH.StartDate

-- SELECT 
--     name AS IndexName, 
--     type_desc AS IndexType, 
--     is_unique AS IsUnique
-- FROM sys.indexes
-- WHERE object_id = OBJECT_ID('dbo.WorkHistory');
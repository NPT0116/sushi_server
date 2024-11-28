CREATE OR ALTER PROC create_dumb_data_submit_reservation
AS
BEGIN
    DECLARE @recordPerBranch INT = 2;
    DECLARE @totalOfBranch INT = (SELECT COUNT(*) FROM Branches);
    DECLARE @branchIndex INT = 1;

    WHILE @branchIndex <= @totalOfBranch
    BEGIN
        DECLARE @branchId UNIQUEIDENTIFIER;

        WITH BranchesCTE AS (
            SELECT 
                branchId, 
                ROW_NUMBER() OVER (ORDER BY branchId) AS branches_row
            FROM Branches
        )
        SELECT @branchId = branchId
        FROM BranchesCTE
        WHERE branches_row = @branchIndex;

        DECLARE @currentRecordCount INT = @recordPerBranch;

        WHILE @currentRecordCount > 0
        BEGIN
            DECLARE @employeeId UNIQUEIDENTIFIER;
            DECLARE @customerId UNIQUEIDENTIFIER;
            DECLARE @tableId UNIQUEIDENTIFIER;
            DECLARE @reservation_id UNIQUEIDENTIFIER;
            DECLARE @dated_on DATETIME;

            SELECT TOP 1 @employeeId = Id FROM Employees WHERE BranchId = @branchId ORDER BY NEWID();
            SELECT TOP 1 @customerId = CustomerId FROM Customers ORDER BY NEWID();
            SELECT TOP 1 @tableId = Id FROM TableDetail 
            WHERE BranchId = @branchId AND Status = 0 ORDER BY NEWID();

            SET @dated_on = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01');

            EXEC submit_reservation @dated_on, 'Dummy Note', 0, 1, @employeeId, @customerId, @branchId, @tableId, @reservation_id OUTPUT;
            EXEC check_out_reservation @reservation_id;

            SET @currentRecordCount = @currentRecordCount - 1;
        END

        SET @branchIndex = @branchIndex + 1;
    END
END;

EXEC create_dumb_data_submit_reservation;

SELECT * FROM Reservation
ORDER BY branchid
DELETE FROM Reservation;

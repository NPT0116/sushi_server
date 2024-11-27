CREATE OR ALTER PROC create_dumb_data_submit_reservation
AS
BEGIN
    DECLARE @record INT = 100000;

    WHILE @record > 0
    BEGIN

		DECLARE @employeeId UNIQUEIDENTIFIER;
		DECLARE @customerId UNIQUEIDENTIFIER;
		DECLARE @branchId UNIQUEIDENTIFIER;
		DECLARE @tableId UNIQUEIDENTIFIER;
		DECLARE @reservation_id UNIQUEIDENTIFIER;

		-- Randomly select IDs
		SELECT TOP 1 @employeeId = Id, @branchId = BranchId FROM Employees ORDER BY NEWID();
		SELECT TOP 1 @customerId = CustomerId FROM Customers ORDER BY NEWID();
		SELECT TOP 1 @tableId = Id FROM TableDetail WHERE status = 0 ORDER BY NEWID();

		-- Use a specific datetime value
		EXEC submit_reservation '2023-10-15 12:00:00', 'note', 0, 1, @employeeId, @customerId, @branchId, @tableId, @reservation_id OUTPUT;
		EXEC check_out_reservation @reservation_id;

		SET @record = @record - 1;
    END
END;
exec create_dumb_data_submit_reservation;

select * from reservation

select * from TableDetail

DROP TABLE IF EXISTS reservation;

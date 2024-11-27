
CREATE OR ALTER FUNCTION check_employee_branch(@ordered_by uniqueidentifier, @branch_id uniqueidentifier)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT * FROM Employees e WHERE e.id = @ordered_by AND e.BranchId = @branch_id)
        RETURN 1;
    RETURN 0;
END
GO
CREATE OR ALTER FUNCTION check_table_suitable(@table_id uniqueidentifier, @max_people bigint)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT * FROM TableDetail t WHERE t.Id = @table_id AND t.Status = 0 AND t.MaxCapacity >= @max_people)
        RETURN 1;
    RETURN 0;
END
GO
-- 2 Submit reservation -> Một đặt chỗ là hợp lệ khi thỏa: nhân viên của chi nhánh đó đặt chỗ, chỗ phải trống, lượng người phù hợp, trong khung giờ mở cửa chi nhánh.
CREATE OR ALTER PROCEDURE submit_reservation 
    @dated_on DATETIME, 
    @note NVARCHAR(255), 
    @status int, 
    @total_people int,
    @ordered_by uniqueidentifier,
    @customer_id uniqueidentifier,
    @branch_id uniqueidentifier,
    @table_id uniqueidentifier,
    @reservation_id uniqueidentifier OUTPUT
AS
BEGIN
    IF dbo.check_employee_branch(@ordered_by, @branch_id) = 0
    BEGIN
        RAISERROR('Nhan vien khong lam viec tai chi nhanh nay', 16, 1);
        RETURN;
    END
    IF dbo.check_table_suitable(@table_id, @total_people) = 0
    BEGIN
        RAISERROR('Ban khong phu hop', 16, 1);
        RETURN;
    END

    

    -- Declare a table variable to capture the inserted ID
    DECLARE @InsertedIds TABLE (Id UNIQUEIDENTIFIER);

    -- Insert reservation and capture the new reservation ID
    INSERT INTO Reservation (Id,DatedOn, Note, "Status", OrderedBy, CustomerId, BranchId, TableId, TotalPeople)
    OUTPUT INSERTED.Id INTO @InsertedIds
    VALUES (NEWID(),@dated_on, @note, @status, @ordered_by, @customer_id, @branch_id, @table_id, @total_people);

    -- Assign the captured ID to the output parameter
    SELECT @reservation_id = Id FROM @InsertedIds;
	-- Trigger update table_detail (status)
    UPDATE TableDetail SET Status = 1 WHERE Id = @table_id;
END
GO

--check out reservation
create or alter proc check_out_reservation @reservation_id uniqueidentifier
as
begin
    update TableDetail set Status = 0 where TableDetail.Id = (select TableId from Reservation where Id = @reservation_id)
end
GO
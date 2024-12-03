CREATE OR ALTER PROCEDURE UpdateReservationStatusAndDetails
    @ReservationId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER,
    @TableId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem ReservationId có tồn tại trong bảng Reservation không
    IF NOT EXISTS (SELECT 1 FROM Reservation WHERE Id = @ReservationId)
    BEGIN
        RAISERROR('Reservation not found.', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem TableId có tồn tại trong bảng TableDetail không
    IF NOT EXISTS (SELECT 1 FROM TableDetail WHERE Id = @TableId and status  = 0)
    BEGIN
        RAISERROR('Table not found or not available', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1 
        FROM Employees e 
        JOIN Reservation r ON r.BranchId = e.BranchId 
        WHERE e.Id = @EmployeeId 
        AND r.Id = @ReservationId
    )
    BEGIN
        RAISERROR('Employee not found or does not belong to the branch of the reservation.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1 
        FROM TableDetail td 
        JOIN Reservation r ON r.BranchId = td.BranchId 
        WHERE td.Id = @TableId 
        AND r.Id = @ReservationId
    )
    BEGIN
        RAISERROR('Table not found or does not belong to the branch of the reservation.', 16, 1);
        RETURN;
    END
    update TableDetail
    set [Status] = 1
    where Id = @TableId
    -- Cập nhật Reservation với EmployeeId (OrderBy), TableId, và Status = 1 (In Progress)
    UPDATE Reservation
    SET 
        OrderedBy = @EmployeeId,      -- Cập nhật nhân viên phụ trách
        TableId = @TableId,           -- Cập nhật số bàn
        Status = 1                    -- Cập nhật trạng thái là "In Progress"
    WHERE 
        Id = @ReservationId;

    -- Trả về thông báo thành công
    SELECT 'Reservation updated successfully' AS Message;
END;


select top 1 * from Invoices order by DatedOn desc
select top 1 o.Id, o.[Status] from Reservation r join orders o on r.Id = o.ReservationId order by r.DatedOn desc

select  tb.Id, tb.[Status] from TableDetail tb join Branches b on b.BranchId = tb.BranchId join Reservation r on r.BranchId = b.BranchId 
where r.Id = '0be776c4-a5c8-40be-a82c-454d9e0cfd48' 


select  tb.Id , tb.Name from Employees tb join Branches b on b.BranchId = tb.BranchId join Reservation r on r.BranchId = b.BranchId 
where r.Id = '0be776c4-a5c8-40be-a82c-454d9e0cfd48' 

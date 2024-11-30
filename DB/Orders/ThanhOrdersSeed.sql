USE sushiDB;
GO

DECLARE @ReservationId UNIQUEIDENTIFIER;
DECLARE @Total BIGINT = 0;  -- Total = 0
DECLARE @Status INT = 2;  -- Status = 2 (Done)
DECLARE @LastModified DATETIME = GETDATE();

-- Lặp qua tất cả các Reservation để tạo Order
DECLARE ReservationCursor CURSOR FOR 
SELECT Id FROM Reservation;

OPEN ReservationCursor;

FETCH NEXT FROM ReservationCursor INTO @ReservationId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tạo mới Order cho từng Reservation
    INSERT INTO Orders (Id, Total, LastModified, Status, ReservationId)
    VALUES (NEWID(), @Total, @LastModified, @Status, @ReservationId);

    FETCH NEXT FROM ReservationCursor INTO @ReservationId;
END

CLOSE ReservationCursor;
DEALLOCATE ReservationCursor;

-- Kiểm tra kết quả




USE sushiDB;
GO

DECLARE @BranchId UNIQUEIDENTIFIER;
DECLARE @CustomerId UNIQUEIDENTIFIER;
DECLARE @EmployeeId UNIQUEIDENTIFIER;
DECLARE @TableId UNIQUEIDENTIFIER;
DECLARE @DatedOn DATETIME;
DECLARE @TotalPeople INT;
DECLARE @ReservationStatus INT = 2;  -- "2" là status Done

DECLARE @Counter INT = 1;
DECLARE @BranchCounter INT = 1;
DECLARE @RowsPerBranch INT = 6666;  -- Chia đều cho mỗi chi nhánh (100k dòng chia 15 chi nhánh)
DECLARE @MaxBranches INT = 15;  -- 15 chi nhánh

-- Lặp qua các chi nhánh
WHILE @BranchCounter <= @MaxBranches
BEGIN
    -- Lặp qua các bản ghi cho chi nhánh hiện tại
    WHILE @Counter <= @RowsPerBranch * @BranchCounter
    BEGIN
        -- Lấy một BranchId ngẫu nhiên
        SELECT @BranchId = BranchId FROM Branches WHERE BranchId = (SELECT TOP 1 BranchId FROM Branches ORDER BY NEWID());

        -- Lấy CustomerId ngẫu nhiên từ bảng Customers
        SELECT @CustomerId = CustomerId FROM Customers ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

        -- Lấy EmployeeId ngẫu nhiên từ Employees của chi nhánh này
        SELECT @EmployeeId = Id FROM Employees WHERE BranchId = @BranchId ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

        -- Lấy TableId ngẫu nhiên thuộc chi nhánh này
        SELECT @TableId = Id FROM TableDetail WHERE BranchId = @BranchId ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

        -- Chọn ngày rải rác trong năm 2024 (trừ tháng 11)
        SET @DatedOn = DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 300), '2024-01-01'); -- Random ngày từ tháng 1 đến tháng 10

        -- Chọn số người random từ 1 đến 5
        SET @TotalPeople = (ABS(CHECKSUM(NEWID())) % 5) + 1;

        -- Chèn bản ghi vào bảng Reservation
        INSERT INTO Reservation (Id, DatedOn, Note, Status, OrderedBy, CustomerId, BranchId, TableId, TotalPeople)
        VALUES (NEWID(), @DatedOn, 'Random reservation', @ReservationStatus, @EmployeeId, @CustomerId, @BranchId, @TableId, @TotalPeople);

        SET @Counter = @Counter + 1;  -- Tăng số lượng bản ghi đã chèn
    END

    SET @BranchCounter = @BranchCounter + 1;  -- Tăng số lượng chi nhánh đã chèn
END

-- Kiểm tra kết quả


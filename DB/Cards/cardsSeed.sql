USE sushiDB;
GO

DECLARE @CustomerId UNIQUEIDENTIFIER;
DECLARE @EmployeeId UNIQUEIDENTIFIER;
DECLARE @RankingId INT;
DECLARE @StartDate DATETIME;
DECLARE @AccumulatedPoints REAL;
DECLARE @AccumulatedDate DATETIME;
DECLARE @CardId UNIQUEIDENTIFIER;  -- Thêm biến để lưu CardId GUID

-- Tạo thẻ cho 1,000 khách hàng
DECLARE @Counter INT = 1;
WHILE @Counter <= 1000
BEGIN
    -- Lấy CustomerId ngẫu nhiên từ bảng Customers
    SELECT @CustomerId = CustomerId FROM Customers ORDER BY NEWID() OFFSET @Counter-1 ROWS FETCH NEXT 1 ROWS ONLY;

    -- Lấy EmployeeId ngẫu nhiên từ bảng Employees
    SELECT @EmployeeId = Id FROM Employees ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

    -- Phân bổ RankingId (10% Gold, 20% Silver, 70% Membership)
    IF (@Counter <= 100) -- 10% Gold
    BEGIN
        SET @RankingId = 3;  -- Gold
    END
    ELSE IF (@Counter <= 300) -- 20% Silver
    BEGIN
        SET @RankingId = 2;  -- Silver
    END
    ELSE -- 70% Membership
    BEGIN
        SET @RankingId = 1;  -- Membership
    END

    -- Cài đặt các thông số khác cho Card
    SET @StartDate = GETDATE();  -- Thẻ bắt đầu từ ngày hiện tại
    SET @AccumulatedPoints = 0;  -- Điểm tích lũy ban đầu là 0
    SET @AccumulatedDate = GETDATE();  -- Ngày tích lũy tính từ ngày bắt đầu

    -- Tạo GUID mới cho mỗi thẻ
    SET @CardId = NEWID();  -- Tạo GUID mới

    -- Insert vào bảng Cards
    INSERT INTO Cards (CardId, StartDate, AccumulatedPoints, Valid, AccumulatedDate, EmployeeId, RankingId, CustomerId)
    VALUES (@CardId, @StartDate, @AccumulatedPoints, 1, @AccumulatedDate, @EmployeeId, @RankingId, @CustomerId);

    SET @Counter = @Counter + 1;
END;

-- Kiểm tra kết quả
SELECT * FROM Cards;

-- Nếu muốn xóa tất cả thẻ trong bảng Cards (chỉ dùng khi cần thiết)
-- delete from Cards;

SELECT * FROM __EFMigrationsHistory;

GO
CREATE OR ALTER TRIGGER trg_UpdateCustomerCardRank
ON Cards
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @AccumulatedPoints INT;
    DECLARE @AccumulatedDate DATE;
    DECLARE @RankingId INT;
    DECLARE @NewRankingId INT;
    DECLARE @NewAccumulatedPoints INT;
    DECLARE @UpgradePoint INT;  -- Lưu trữ điểm yêu cầu để nâng hạng từ bảng Rankings

    -- Lấy thông tin thẻ từ bảng Cards
    SELECT 
        @CustomerId = CustomerId, 
        @AccumulatedPoints = AccumulatedPoints,
        @AccumulatedDate = AccumulatedDate,
        @RankingId = RankingId
    FROM INSERTED;  -- Tham chiếu bảng INSERTED để lấy dữ liệu vừa được cập nhật

    -- Lấy thông tin về `UpgradePoint` từ bảng Rankings dựa trên `RankingId`
    SELECT @UpgradePoint = r.UpgradePoint
    FROM Rankings r
    WHERE r.Id = @RankingId;

    -- Kiểm tra nếu điểm tích lũy lớn hơn `UpgradePoint` thì nâng hạng
    IF @AccumulatedPoints >= @UpgradePoint
    BEGIN
        -- Nếu là Silver (RankingId = 2), nâng hạng lên Gold (RankingId = 3)
        IF @RankingId = 2
        BEGIN
            SET @NewRankingId = 3;  -- Nâng hạng lên Gold
            SET @NewAccumulatedPoints = 0;  -- Reset điểm tích lũy khi nâng hạng
        END
        -- Nếu là Membership (RankingId = 1), nâng hạng lên Silver (RankingId = 2)
        ELSE IF @RankingId = 1
        BEGIN
            SET @NewRankingId = 2;  -- Nâng hạng lên Silver
            SET @NewAccumulatedPoints = 0;  -- Reset điểm tích lũy khi nâng hạng
        END
        ELSE
        BEGIN
            -- Nếu đang là Gold (RankingId = 3), không nâng hạng nữa
            RETURN;  -- Không làm gì vì thẻ đã ở mức cao nhất
        END

        -- Cập nhật thông tin thẻ (nâng hạng)
        UPDATE Cards
        SET 
            RankingId = @NewRankingId,  -- Cập nhật hạng mới
            AccumulatedPoints = @NewAccumulatedPoints,  -- Reset điểm tích lũy
            AccumulatedDate = GETDATE()  -- Cập nhật ngày nâng hạng là ngày hiện tại
        WHERE CustomerId = @CustomerId;

        PRINT 'Card upgraded successfully!';
    END
    ELSE
    BEGIN
        -- Nếu không đủ điểm để nâng hạng, không làm gì
        RETURN;
    END
END;

select * from rankings


-- giáng hạng thẻ


GO
CREATE TRIGGER trg_DemoteCustomerCard
ON Cards
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @AccumulatedPoints INT;
    DECLARE @AccumulatedDate DATE;
    DECLARE @RankingId INT;
    DECLARE @DaysSinceAccumulated INT;
    DECLARE @NewRankingId INT;
    DECLARE @NewAccumulatedPoints INT;
    DECLARE @RequirePoint INT;
    DECLARE @UpgradePoint INT;

    -- Lấy thông tin thẻ từ bảng Cards
    SELECT 
        @CustomerId = CustomerId, 
        @AccumulatedPoints = AccumulatedPoints,
        @AccumulatedDate = AccumulatedDate,
        @RankingId = RankingId
    FROM INSERTED;  -- Tham chiếu bảng INSERTED để lấy dữ liệu vừa được cập nhật

    -- Lấy thông tin về `RequirePoint` và `UpgradePoint` từ bảng Rankings dựa trên `RankingId`
    SELECT 
        @RequirePoint = r.RequirePoint,  -- Điểm yêu cầu để duy trì hạng
        @UpgradePoint = r.UpgradePoint  -- Điểm yêu cầu để nâng hạng
    FROM Rankings r
    WHERE r.Id = @RankingId;

    -- Kiểm tra thời gian từ `AccumulatedDate` đến ngày hiện tại
    SET @DaysSinceAccumulated = DATEDIFF(DAY, @AccumulatedDate, GETDATE());

    -- Kiểm tra điều kiện để giáng hạng hoặc duy trì thẻ
    IF @RankingId = 1  -- Thẻ Thành viên (Membership)
    BEGIN
        -- Nếu thẻ là Membership thì không giáng hạng, chỉ kiểm tra xem có đủ điểm để nâng hạng không
        RETURN;
    END
    ELSE IF @RankingId = 2  -- Thẻ Bạc (Silver)
    BEGIN
        -- Giảm hạng xuống Membership nếu thẻ Bạc không đủ điều kiện
        IF @DaysSinceAccumulated > 365 AND @AccumulatedPoints < @RequirePoint
        BEGIN
            -- Giáng hạng về "Membership"
            SET @NewRankingId = 1;  -- Giảm xuống Membership
            SET @NewAccumulatedPoints = 0;  -- Reset điểm tích lũy
            UPDATE Cards
            SET 
                RankingId = @NewRankingId,  -- Cập nhật hạng mới
                AccumulatedPoints = @NewAccumulatedPoints,  -- Reset điểm tích lũy
                AccumulatedDate = GETDATE()  -- Cập nhật ngày giáng hạng là ngày hiện tại
            WHERE CustomerId = @CustomerId;
        END
        ELSE
        BEGIN
            -- Nếu vẫn đủ điều kiện, không làm gì
            RETURN;
        END
    END
    ELSE IF @RankingId = 3  -- Thẻ Vàng (Gold)
    BEGIN
        -- Giảm hạng xuống Silver nếu thẻ Vàng không đủ điều kiện
        IF @DaysSinceAccumulated > 365 AND @AccumulatedPoints < @RequirePoint
        BEGIN
            -- Giáng hạng về "Silver"
            SET @NewRankingId = 2;  -- Giảm xuống Silver
            SET @NewAccumulatedPoints = 0;  -- Reset điểm tích lũy
            UPDATE Cards
            SET 
                RankingId = @NewRankingId,  -- Cập nhật hạng mới
                AccumulatedPoints = @NewAccumulatedPoints,  -- Reset điểm tích lũy
                AccumulatedDate = GETDATE()  -- Cập nhật ngày giáng hạng là ngày hiện tại
            WHERE CustomerId = @CustomerId;
        END
        ELSE
        BEGIN
            -- Nếu vẫn đủ điều kiện, không làm gì
            RETURN;
        END
    END

    -- Trả về thông báo (có thể bỏ qua, nếu không cần thiết)
    PRINT 'Card processing completed successfully!';
END;

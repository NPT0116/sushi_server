USE sushiDB;
GO

DECLARE @OrderId UNIQUEIDENTIFIER;
DECLARE @ReservationId UNIQUEIDENTIFIER;
DECLARE @BranchId UNIQUEIDENTIFIER;
DECLARE @DishId UNIQUEIDENTIFIER;
DECLARE @Quantity INT;
DECLARE @Price INT;
DECLARE @Total BIGINT;
DECLARE @Counter INT = 1;

-- Lặp qua tất cả các Order
DECLARE OrderCursor CURSOR FOR
SELECT Id, ReservationId FROM Orders;

OPEN OrderCursor;

FETCH NEXT FROM OrderCursor INTO @OrderId, @ReservationId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Lấy BranchId từ Reservation
    SELECT @BranchId = BranchId
    FROM Reservation
    WHERE Id = @ReservationId;

    -- Đặt lại tổng cho Order
    SET @Total = 0;

    -- Chọn ngẫu nhiên từ 4 đến 5 món ăn phục vụ tại chi nhánh này
    DECLARE @OrderDetailCounter INT = 1;
    WHILE @OrderDetailCounter <= (FLOOR(RAND() * 2) + 4)  -- Chọn ngẫu nhiên 4-5 món
    BEGIN
        -- Chọn DishId ngẫu nhiên từ Dishes có sẵn ở chi nhánh này
        SELECT @DishId = DishId
        FROM Dishes
        WHERE SectionId IN (SELECT SectionId FROM BranchDishes WHERE BranchId = @BranchId)
        ORDER BY NEWID()
        OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

        -- Chọn Quantity ngẫu nhiên từ 1-3
        SET @Quantity = (ABS(CHECKSUM(NEWID())) % 3) + 1;

        -- Lấy giá món ăn
        SELECT @Price = CurrentPrice
        FROM Dishes
        WHERE DishId = @DishId;

        -- Tính tổng cho OrderDetails và cập nhật vào Order
        INSERT INTO OrderDetail (Id, Status, Price, Quantity, DishId, OrderId)
        VALUES (NEWID(), 2, @Price, @Quantity, @DishId, @OrderId);

        -- Cập nhật lại tổng tiền cho Order
        SET @Total = @Total + (@Price * @Quantity);

        SET @OrderDetailCounter = @OrderDetailCounter + 1;
    END

    -- Cập nhật lại tổng tiền cho Order
    UPDATE Orders
    SET Total = @Total
    WHERE Id = @OrderId;

    FETCH NEXT FROM OrderCursor INTO @OrderId, @ReservationId;
END

CLOSE OrderCursor;
DEALLOCATE OrderCursor;

-- Kiểm tra kết quả
SELECT count(*) FROM OrderDetail;
SELECT * FROM Orders;

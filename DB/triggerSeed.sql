-- trigger tự động cập nhật lại total của order khi thêm 1 order detail 
GO
CREATE OR ALTER TRIGGER trg_UpdateOrderTotal
ON OrderDetail
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OrderId UNIQUEIDENTIFIER;
    DECLARE @NewTotal DECIMAL(18, 2);

    -- Kiểm tra xem có dòng dữ liệu nào bị ảnh hưởng
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        -- Lấy OrderId từ bảng inserted (có thể là một hoặc nhiều bản ghi)
        SELECT @OrderId = OrderId FROM inserted;

        -- Tính lại tổng giá trị của Order dựa trên OrderDetail
        SELECT @NewTotal = SUM(Price * Quantity)
        FROM OrderDetail
        WHERE OrderId = @OrderId;

        -- Cập nhật lại trường Total trong bảng Orders
        UPDATE Orders
        SET Total = @NewTotal
        WHERE Id = @OrderId;
    END
END;



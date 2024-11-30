-- Bật IDENTITY_INSERT cho bảng Rankings
SET IDENTITY_INSERT Rankings ON;

-- Chèn giá trị vào bảng Rankings
INSERT INTO Rankings (id, Name, RequirePoint, Discount, UpgradePoint) 
VALUES
    (1, 'Membership', 0, 5, 100),
    (2, 'Silver', 50, 10, 100),
    (3, 'Gold', 100, 15, 2147483647);

-- Tắt IDENTITY_INSERT sau khi chèn xong
SET IDENTITY_INSERT Rankings OFF;

-- Kiểm tra kết quả
SELECT * FROM Rankings;


use sushiDB;
go


INSERT INTO BranchDishes (BranchDishId, BranchId, DishId, Status, ShipStatus)
SELECT NEWID(), -- Tạo BranchDishId mới với kiểu uniqueidentifier
       Branches.BranchId,
       Dishes.DishId,
       CAST((ABS(CHECKSUM(NEWID())) % 2) AS BIT) AS Status, -- Tạo ngẫu nhiên giá trị Status (0 hoặc 1)
       CAST((ABS(CHECKSUM(NEWID())) % 2) AS BIT) AS ShipStatus -- Tạo ngẫu nhiên giá trị ShipStatus (0 hoặc 1)
FROM Branches
CROSS JOIN Dishes;




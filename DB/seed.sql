use sushiDB;
go




go
-- INSERT BRANCH
-- Insert 15 branches
INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 1', '123 Main St', '0123456789', '08:00:00', '22:00:00', 1, 1, 1, 20);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 2', '456 Maple Ave', '0987654321', '09:00:00', '21:00:00', 1, 1, 0, 15);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 3', '789 Oak St', '0165432198', '10:00:00', '20:00:00', 0, 1, 1, 25);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 4', '101 Pine Rd', '0192837465', '08:30:00', '22:30:00', 1, 1, 0, 30);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 5', '202 Birch Blvd', '0147852369', '09:30:00', '23:00:00', 0, 1, 1, 12);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 6', '303 Cedar Dr', '0172639485', '07:00:00', '19:00:00', 1, 1, 1, 18);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 7', '404 Elm St', '0132748596', '11:00:00', '23:00:00', 0, 1, 1, 22);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 8', '505 Poplar St', '0183649572', '08:00:00', '22:00:00', 1, 0, 1, 16);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 9', '606 Walnut Ave', '0123948576', '09:00:00', '21:00:00', 1, 1, 0, 24);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 10', '707 Chestnut Ln', '0194857362', '10:00:00', '20:00:00', 0, 1, 1, 26);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 11', '808 Spruce Ct', '0172846395', '08:30:00', '22:30:00', 1, 1, 1, 19);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 12', '909 Fir Ave', '0183749562', '09:30:00', '23:00:00', 1, 1, 0, 14);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 13', '1010 Ash St', '0162938475', '07:00:00', '19:00:00', 1, 1, 1, 28);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 14', '1111 Redwood Blvd', '0123649857', '11:00:00', '23:00:00', 0, 0, 1, 20);

INSERT INTO Branches (BranchId, ManagerId, Name, Address, Phone, OpeningTime, ClosingTime, CarParking, MotorParking, Ship, TotalTable)
VALUES (NEWID(), NULL, 'Branch 15', '1212 Sequoia Ln', '0192836457', '08:00:00', '22:00:00', 1, 1, 0, 17);
use sushiDB;

GO
--table detail
DECLARE @BranchId UNIQUEIDENTIFIER
DECLARE @TableCount INT = 10 -- Number of tables per branch
DECLARE @Counter INT
DECLARE @MaxPeople INT

-- Cursor to loop through each branch
DECLARE BranchCursor CURSOR FOR
SELECT BranchId FROM Branches

OPEN BranchCursor
FETCH NEXT FROM BranchCursor INTO @BranchId

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Counter = 1 -- Reset the counter for each branch

    WHILE @Counter <= @TableCount
    BEGIN
        -- Generate a random MaxPeople between 2 and 10
        SET @MaxPeople = 5 + (ABS(CHECKSUM(NEWID())) % 9)

        -- Insert a new TableDetail record for each table in this branch
        INSERT INTO TableDetail (TableId, BranchId, TableNumber, MaxPeople, Status)
        VALUES (NEWID(), @BranchId, @Counter, @MaxPeople, 0) -- Status set to false (0)

        -- Increment the counter for TableNumber
        SET @Counter = @Counter + 1
    END

    -- Move to the next branch
    FETCH NEXT FROM BranchCursor INTO @BranchId
END

-- Clean up the cursor
CLOSE BranchCursor
DEALLOCATE BranchCursor

GO





-- Existing sections
INSERT INTO Sections (SectionId, SectionName) VALUES ('E518919A-5662-40C5-8468-AE4A3CE70A80', 'Appetizers');
INSERT INTO Sections (SectionId, SectionName) VALUES ('1991D314-DB2B-47EB-88DC-0F1CD8A60B45', 'Beverages');
INSERT INTO Sections (SectionId, SectionName) VALUES ('242DC005-A807-40E2-BAEF-CAF01F3CCD24', 'Desserts');
INSERT INTO Sections (SectionId, SectionName) VALUES ('9BD51261-8C72-4976-8F7E-6C16772A6001', 'Main Course');

-- Additional sections
INSERT INTO Sections (SectionId, SectionName) VALUES ('A5D6A781-3D0A-4B89-93A3-123456789ABC', 'Salads');
INSERT INTO Sections (SectionId, SectionName) VALUES ('C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA', 'Specials');
INSERT INTO Sections (SectionId, SectionName) VALUES ('B2A4D6E1-1F54-4A22-9E77-789ABCDEF012', 'Kids Menu');


go
-- add dishes after

-- Adding 50 random dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spicy Tuna Roll', 120000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Caesar Salad', 80000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'French Fries', 50000, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'BBQ Ribs', 200000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Margherita Pizza', 150000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Cheese Burger', 70000, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spring Rolls', 60000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lemonade', 40000, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Apple Pie', 50000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Sushi Platter', 250000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');

-- Add more random dishes with varying SectionId and prices
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Wings', 100000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Steak', 300000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lobster Bisque', 180000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chocolate Cake', 60000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Margarita', 80000, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vegetable Stir Fry', 110000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Bacon Burger', 140000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Chicken Nuggets', 60000, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Ice Cream Sundae', 50000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Greek Salad', 90000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');

-- Continue adding more dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spaghetti Bolognese', 120000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Orange Juice', 30000, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Shrimp Cocktail', 150000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Nachos', 70000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vanilla Milkshake', 40000, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Caesar Wrap', 110000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Crab Cakes', 160000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Stuffed Mushrooms', 90000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fried Shrimp', 130000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Cauliflower Bites', 70000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');

-- Continue with more dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Mac and Cheese', 80000, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Sashimi Platter', 180000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pasta Alfredo', 140000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Coke', 30000, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Brownie', 50000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Tuna Tartare', 140000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Beef Tacos', 100000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fried Rice', 80000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pancakes', 60000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Chicken Tenders', 60000, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');

-- Adding more random dishes (from 41 to 80)
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Alfredo', 160000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Peking Duck', 220000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lamb Chops', 280000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Grilled Shrimp', 180000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fried Calamari', 140000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Cheesecake', 80000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Tiramisu', 90000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pasta Primavera', 130000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Eggplant Parmesan', 140000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'BBQ Chicken Pizza', 170000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');

-- Add more random dishes with varying SectionId and prices
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Duck Confit', 250000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Prawn Tempura', 150000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Beef Wellington', 350000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Ravioli', 130000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Garlic Bread', 50000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Mushroom Soup', 70000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lobster Roll', 250000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Beef Burritos', 100000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Biryani', 120000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Grilled Vegetables', 80000, '9BD51261-8C72-4976-8F7E-6C16772A6001');

-- Continue adding more dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pork Schnitzel', 150000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Sautéed Mushrooms', 60000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pineapple Fried Rice', 90000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lobster Tail', 350000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Risotto', 130000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Clam Chowder', 100000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Bangers and Mash', 150000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Cheese Plate', 120000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Duck Breast', 250000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Maki Rolls', 140000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');

-- Final dishes to complete the list
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vegetarian Lasagna', 150000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Salmon Fillet', 180000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Marinated Olives', 70000, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pork Belly', 190000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vegetable Samosas', 80000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Oysters', 200000, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Waffle', 90000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vegetable Tacos', 110000, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lamb Kofta', 160000, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Baked Alaska', 120000, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');


go


-- branch dishes

INSERT INTO BranchDishes (BranchDishId, BranchId, DishId, Status, ShipStatus)
SELECT NEWID(), -- Tạo BranchDishId mới với kiểu uniqueidentifier
       Branches.BranchId,
       Dishes.DishId,
       CAST((ABS(CHECKSUM(NEWID())) % 2) AS BIT) AS Status, -- Tạo ngẫu nhiên giá trị Status (0 hoặc 1)
       CAST((ABS(CHECKSUM(NEWID())) % 2) AS BIT) AS ShipStatus -- Tạo ngẫu nhiên giá trị ShipStatus (0 hoặc 1)
FROM Branches
CROSS JOIN Dishes;

go


--department
INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Lao công', 3000000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Bảo vệ', 4000000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Nhân viên', 5000000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Quản lý', 7000000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Kế toán', 6000000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Nhân sự', 5500000);

INSERT INTO Departments (DepartmentId, DepartmentName, BaseSalary)
VALUES (NEWID(), N'Thu ngân', 4500000);

GO





create table employeesName 
(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    name NVARCHAR(50)
)

insert into employeesName( id , Name ) values ( NEWID() , 'Sheelagh Hlavecek');
insert into employeesName( id , Name ) values ( NEWID() , 'Alexa Brocklehurst');
insert into employeesName( id , Name ) values ( NEWID() , 'Frieda Sherme');
insert into employeesName( id , Name ) values ( NEWID() , 'Wake Bartholomieu');
insert into employeesName( id , Name ) values ( NEWID() , 'Marcia Jarritt');
insert into employeesName( id , Name ) values ( NEWID() , 'Wandis Boustred');
insert into employeesName( id , Name ) values ( NEWID() , 'Andy Arnli');
insert into employeesName( id , Name ) values ( NEWID() , 'Sarge Ca');
insert into employeesName( id , Name ) values ( NEWID() , 'Barnaby Jenney');
insert into employeesName( id , Name ) values ( NEWID() , 'Kimmi Murtagh');
insert into employeesName( id , Name ) values ( NEWID() , 'Julissa Hartshorne');
insert into employeesName( id , Name ) values ( NEWID() , 'Fredelia Lidyard');
insert into employeesName( id , Name ) values ( NEWID() , 'Dean Litterick');
insert into employeesName( id , Name ) values ( NEWID() , 'Cesya Butteris');
insert into employeesName( id , Name ) values ( NEWID() , 'Lazarus Izacenko');
insert into employeesName( id , Name ) values ( NEWID() , 'Antonietta Asple');
insert into employeesName( id , Name ) values ( NEWID() , 'Lindsey Labroue');
insert into employeesName( id , Name ) values ( NEWID() , 'Rozanne Rylatt');
insert into employeesName( id , Name ) values ( NEWID() , 'Orin Abelovitz');
insert into employeesName( id , Name ) values ( NEWID() , 'Christabel Buzek');
insert into employeesName( id , Name ) values ( NEWID() , 'Gwendolyn Penke');
insert into employeesName( id , Name ) values ( NEWID() , 'Gilbert Menel');
insert into employeesName( id , Name ) values ( NEWID() , 'Dorene Narducci');
insert into employeesName( id , Name ) values ( NEWID() , 'Laurie Bratley');
insert into employeesName( id , Name ) values ( NEWID() , 'Jacquelynn Taye');
insert into employeesName( id , Name ) values ( NEWID() , 'Marleah Andreone');
insert into employeesName( id , Name ) values ( NEWID() , 'Lana Stading');
insert into employeesName( id , Name ) values ( NEWID() , 'Chalmers Batter');
insert into employeesName( id , Name ) values ( NEWID() , 'Simonne Andrick');
insert into employeesName( id , Name ) values ( NEWID() , 'Papagena Souttar');
insert into employeesName( id , Name ) values ( NEWID() , 'Decca Coo');
insert into employeesName( id , Name ) values ( NEWID() , 'Trueman Mikalski');
insert into employeesName( id , Name ) values ( NEWID() , 'Tildi Peterkin');
insert into employeesName( id , Name ) values ( NEWID() , 'Fan Crozier');
insert into employeesName( id , Name ) values ( NEWID() , 'Winfred Duck');
insert into employeesName( id , Name ) values ( NEWID() , 'Hatti Gallgher');
insert into employeesName( id , Name ) values ( NEWID() , 'Priscella Giampietro');
insert into employeesName( id , Name ) values ( NEWID() , 'Ruby Jex');
insert into employeesName( id , Name ) values ( NEWID() , 'Lyndsey Rist');
insert into employeesName( id , Name ) values ( NEWID() , 'Sidoney Cardenosa');
insert into employeesName( id , Name ) values ( NEWID() , 'Rudolf Gladebeck');
insert into employeesName( id , Name ) values ( NEWID() , 'Pauli Tome');
insert into employeesName( id , Name ) values ( NEWID() , 'Robbie Brierly');
insert into employeesName( id , Name ) values ( NEWID() , 'Fawnia Dinneen');
insert into employeesName( id , Name ) values ( NEWID() , 'Dniren Rowlinson');
insert into employeesName( id , Name ) values ( NEWID() , 'Wayne Garrow');
insert into employeesName( id , Name ) values ( NEWID() , 'Jammal Holbarrow');
insert into employeesName( id , Name ) values ( NEWID() , 'Ermentrude Lyall');
insert into employeesName( id , Name ) values ( NEWID() , 'Mordecai Cockerham');
insert into employeesName( id , Name ) values ( NEWID() , 'Briant Gaylard');
insert into employeesName( id , Name ) values ( NEWID() , 'Dania Fransemai');
insert into employeesName( id , Name ) values ( NEWID() , 'Persis Bostick');
insert into employeesName( id , Name ) values ( NEWID() , 'Simeon Pointer');
insert into employeesName( id , Name ) values ( NEWID() , 'Torrance Tomasutti');
insert into employeesName( id , Name ) values ( NEWID() , 'Dorotea Lindbergh');
insert into employeesName( id , Name ) values ( NEWID() , 'Sara-ann Russam');
insert into employeesName( id , Name ) values ( NEWID() , 'Gusty Doncaster');
insert into employeesName( id , Name ) values ( NEWID() , 'Berti Krol');
insert into employeesName( id , Name ) values ( NEWID() , 'Eal Sincock');
insert into employeesName( id , Name ) values ( NEWID() , 'Amble Dudden');
insert into employeesName( id , Name ) values ( NEWID() , 'Gearalt Archdeacon');
insert into employeesName( id , Name ) values ( NEWID() , 'Wilburt Fiennes');
insert into employeesName( id , Name ) values ( NEWID() , 'Alyda Scott');
insert into employeesName( id , Name ) values ( NEWID() , 'Vincenty Robison');
insert into employeesName( id , Name ) values ( NEWID() , 'Yank Haill');
insert into employeesName( id , Name ) values ( NEWID() , 'Maximilien Povele');
insert into employeesName( id , Name ) values ( NEWID() , 'Henrie Gigg');
insert into employeesName( id , Name ) values ( NEWID() , 'Karly Poltone');
insert into employeesName( id , Name ) values ( NEWID() , 'Amargo Willard');
insert into employeesName( id , Name ) values ( NEWID() , 'Harley Cubbit');
insert into employeesName( id , Name ) values ( NEWID() , 'Dante Cheel');
insert into employeesName( id , Name ) values ( NEWID() , 'Delila Brignall');
insert into employeesName( id , Name ) values ( NEWID() , 'Loralie Wikey');
insert into employeesName( id , Name ) values ( NEWID() , 'Elladine Gittoes');
insert into employeesName( id , Name ) values ( NEWID() , 'Nial Winson');
insert into employeesName( id , Name ) values ( NEWID() , 'Rosamond Danzelman');
insert into employeesName( id , Name ) values ( NEWID() , 'Haskell Wass');
insert into employeesName( id , Name ) values ( NEWID() , 'Juana Queree');
insert into employeesName( id , Name ) values ( NEWID() , 'Millicent Haywood');
insert into employeesName( id , Name ) values ( NEWID() , 'Tamarra Skynner');
insert into employeesName( id , Name ) values ( NEWID() , 'Sarina MacLaverty');
insert into employeesName( id , Name ) values ( NEWID() , 'Theda Hale');
insert into employeesName( id , Name ) values ( NEWID() , 'Griffy Koubek');
insert into employeesName( id , Name ) values ( NEWID() , 'Cullie Matteoni');
insert into employeesName( id , Name ) values ( NEWID() , 'Corty Hathaway');
insert into employeesName( id , Name ) values ( NEWID() , 'Sharl Eisikowitz');
insert into employeesName( id , Name ) values ( NEWID() , 'Hermie Gatman');
insert into employeesName( id , Name ) values ( NEWID() , 'Della Moses');
insert into employeesName( id , Name ) values ( NEWID() , 'Domenic Whitelock');
insert into employeesName( id , Name ) values ( NEWID() , 'Alejandro Easum');
insert into employeesName( id , Name ) values ( NEWID() , 'Julieta Duny');
insert into employeesName( id , Name ) values ( NEWID() , 'Constantine Trengrove');
insert into employeesName( id , Name ) values ( NEWID() , 'Mathian Garner');
insert into employeesName( id , Name ) values ( NEWID() , 'Hillery Saiens');
insert into employeesName( id , Name ) values ( NEWID() , 'Dorine Schwartz');
insert into employeesName( id , Name ) values ( NEWID() , 'Hollyanne Kestian');
insert into employeesName( id , Name ) values ( NEWID() , 'Basile Brigden');
insert into employeesName( id , Name ) values ( NEWID() , 'Cyril Hanburry');
insert into employeesName( id , Name ) values ( NEWID() , 'Irvine Mulholland');
insert into employeesName( id , Name ) values ( NEWID() , 'Nathanil Crummey');
insert into employeesName( id , Name ) values ( NEWID() , 'Taylor Ducarne');
insert into employeesName( id , Name ) values ( NEWID() , 'Sallie Frayne');
insert into employeesName( id , Name ) values ( NEWID() , 'Kermit Clemo');
insert into employeesName( id , Name ) values ( NEWID() , 'Tonye McGeachie');
insert into employeesName( id , Name ) values ( NEWID() , 'Ameline Dowzell');
insert into employeesName( id , Name ) values ( NEWID() , 'Laurena McGilben');
insert into employeesName( id , Name ) values ( NEWID() , 'Scotty Thornber');
insert into employeesName( id , Name ) values ( NEWID() , 'Kathlin Papworth');
insert into employeesName( id , Name ) values ( NEWID() , 'Jeana Novacek');
insert into employeesName( id , Name ) values ( NEWID() , 'Karmen Aldcorne');
insert into employeesName( id , Name ) values ( NEWID() , 'Nicola Hotton');
insert into employeesName( id , Name ) values ( NEWID() , 'Prudi Edinburough');
insert into employeesName( id , Name ) values ( NEWID() , 'Valentijn Le Fleming');
insert into employeesName( id , Name ) values ( NEWID() , 'Keefer Guinan');
insert into employeesName( id , Name ) values ( NEWID() , 'Eal Reynalds');
insert into employeesName( id , Name ) values ( NEWID() , 'Julianna Pickover');
insert into employeesName( id , Name ) values ( NEWID() , 'Bryanty Lippo');
insert into employeesName( id , Name ) values ( NEWID() , 'Kass Saffle');
insert into employeesName( id , Name ) values ( NEWID() , 'Deerdre McGraw');
insert into employeesName( id , Name ) values ( NEWID() , 'Miller Dumbellow');
insert into employeesName( id , Name ) values ( NEWID() , 'Ivie Dimmick');
insert into employeesName( id , Name ) values ( NEWID() , 'Angelica MacKibbon');
insert into employeesName( id , Name ) values ( NEWID() , 'Batsheva Taverner');
insert into employeesName( id , Name ) values ( NEWID() , 'Nonna Fulleylove');
insert into employeesName( id , Name ) values ( NEWID() , 'Thomasine Fleming');
insert into employeesName( id , Name ) values ( NEWID() , 'Ado Huffey');
insert into employeesName( id , Name ) values ( NEWID() , 'Tome Inchbald');
insert into employeesName( id , Name ) values ( NEWID() , 'Sharona Inskipp');
insert into employeesName( id , Name ) values ( NEWID() , 'Ursula Meaton');
insert into employeesName( id , Name ) values ( NEWID() , 'Angela Dykins');
insert into employeesName( id , Name ) values ( NEWID() , 'Meredith Axe');
insert into employeesName( id , Name ) values ( NEWID() , 'Harrietta Mulqueen');
insert into employeesName( id , Name ) values ( NEWID() , 'Carroll Abdee');
insert into employeesName( id , Name ) values ( NEWID() , 'Ivar Aveson');
insert into employeesName( id , Name ) values ( NEWID() , 'Crissy Gregor');
insert into employeesName( id , Name ) values ( NEWID() , 'Colet Macbeth');
insert into employeesName( id , Name ) values ( NEWID() , 'Roch Grimsditch');
insert into employeesName( id , Name ) values ( NEWID() , 'Berrie Thys');
insert into employeesName( id , Name ) values ( NEWID() , 'Giorgi Dearth');
insert into employeesName( id , Name ) values ( NEWID() , 'Sofia Aherne');
insert into employeesName( id , Name ) values ( NEWID() , 'Marylin Sargint');
insert into employeesName( id , Name ) values ( NEWID() , 'Emanuel Garrett');
insert into employeesName( id , Name ) values ( NEWID() , 'Duncan Blaine');
insert into employeesName( id , Name ) values ( NEWID() , 'Eldredge Holligan');
insert into employeesName( id , Name ) values ( NEWID() , 'Catarina Petyakov');
insert into employeesName( id , Name ) values ( NEWID() , 'Erina Gallone');
insert into employeesName( id , Name ) values ( NEWID() , 'Kaitlyn Akester');
insert into employeesName( id , Name ) values ( NEWID() , 'Galen Noyes');
insert into employeesName( id , Name ) values ( NEWID() , 'Jermayne Krienke');
insert into employeesName( id , Name ) values ( NEWID() , 'Marni Freschi');
insert into employeesName( id , Name ) values ( NEWID() , 'Riordan Doberer');
insert into employeesName( id , Name ) values ( NEWID() , 'Frederico Willett');
insert into employeesName( id , Name ) values ( NEWID() , 'Alvis Housegoe');
insert into employeesName( id , Name ) values ( NEWID() , 'Thoma Bamell');
insert into employeesName( id , Name ) values ( NEWID() , 'Pembroke Goodband');
insert into employeesName( id , Name ) values ( NEWID() , 'Erina Guittet');
insert into employeesName( id , Name ) values ( NEWID() , 'Agnese Sedgemore');
insert into employeesName( id , Name ) values ( NEWID() , 'Lebbie Matthessen');
insert into employeesName( id , Name ) values ( NEWID() , 'Amelina Marl');
insert into employeesName( id , Name ) values ( NEWID() , 'Alanna Boni');
insert into employeesName( id , Name ) values ( NEWID() , 'Hilarius Pickin');
insert into employeesName( id , Name ) values ( NEWID() , 'Estel Humphris');
insert into employeesName( id , Name ) values ( NEWID() , 'Jaynell Alker');
insert into employeesName( id , Name ) values ( NEWID() , 'Christi Liveing');
insert into employeesName( id , Name ) values ( NEWID() , 'Barclay Saffen');
insert into employeesName( id , Name ) values ( NEWID() , 'Haslett Cinavas');
insert into employeesName( id , Name ) values ( NEWID() , 'Yvette Maun');
insert into employeesName( id , Name ) values ( NEWID() , 'Xever Isoldi');
insert into employeesName( id , Name ) values ( NEWID() , 'Celestia Caulcutt');
insert into employeesName( id , Name ) values ( NEWID() , 'Georgeanne Honeyghan');
insert into employeesName( id , Name ) values ( NEWID() , 'Maiga Noni');
insert into employeesName( id , Name ) values ( NEWID() , 'Lannie Duker');
insert into employeesName( id , Name ) values ( NEWID() , 'Dulcine Rumbelow');
insert into employeesName( id , Name ) values ( NEWID() , 'Tierney Stroud');
insert into employeesName( id , Name ) values ( NEWID() , 'Lanie Bernholt');
insert into employeesName( id , Name ) values ( NEWID() , 'Cody M''Quhan');
insert into employeesName( id , Name ) values ( NEWID() , 'Diena McKane');
insert into employeesName( id , Name ) values ( NEWID() , 'Meryl Iacobassi');
insert into employeesName( id , Name ) values ( NEWID() , 'Haroun Legate');
insert into employeesName( id , Name ) values ( NEWID() , 'Charmian Aherne');
insert into employeesName( id , Name ) values ( NEWID() , 'Rasla McVrone');
insert into employeesName( id , Name ) values ( NEWID() , 'Debor McIlraith');
insert into employeesName( id , Name ) values ( NEWID() , 'Roberta Takos');
insert into employeesName( id , Name ) values ( NEWID() , 'Van Libbey');
insert into employeesName( id , Name ) values ( NEWID() , 'Jobye Messier');
insert into employeesName( id , Name ) values ( NEWID() , 'Foss Clynter');
insert into employeesName( id , Name ) values ( NEWID() , 'Richard Mea');
insert into employeesName( id , Name ) values ( NEWID() , 'Tamma Grut');
insert into employeesName( id , Name ) values ( NEWID() , 'Jule Grosier');
insert into employeesName( id , Name ) values ( NEWID() , 'Renaud Allkins');
insert into employeesName( id , Name ) values ( NEWID() , 'Marillin Salvadori');
insert into employeesName( id , Name ) values ( NEWID() , 'Hanson Emmines');
insert into employeesName( id , Name ) values ( NEWID() , 'Devina Rawnsley');
insert into employeesName( id , Name ) values ( NEWID() , 'Melissa Wrighton');
insert into employeesName( id , Name ) values ( NEWID() , 'Jamesy Shitliffe');
insert into employeesName( id , Name ) values ( NEWID() , 'Ogdon Eade');
insert into employeesName( id , Name ) values ( NEWID() , 'Kenny Cowdery');
insert into employeesName( id , Name ) values ( NEWID() , 'Berte Minogue');
insert into employeesName( id , Name ) values ( NEWID() , 'Davey Astlett');
insert into employeesName( id , Name ) values ( NEWID() , 'Rosalie Bootes');
insert into employeesName( id , Name ) values ( NEWID() , 'Amii Dunley');
insert into employeesName( id , Name ) values ( NEWID() , 'Quintina Harnott');
insert into employeesName( id , Name ) values ( NEWID() , 'Joellen Pentecust');
insert into employeesName( id , Name ) values ( NEWID() , 'Archambault Mackin');
insert into employeesName( id , Name ) values ( NEWID() , 'Baxy Condon');
insert into employeesName( id , Name ) values ( NEWID() , 'Adrianna Copnell');
insert into employeesName( id , Name ) values ( NEWID() , 'Corry Stubley');
insert into employeesName( id , Name ) values ( NEWID() , 'Rhett Dilleway');
insert into employeesName( id , Name ) values ( NEWID() , 'Sherye Baudoux');
insert into employeesName( id , Name ) values ( NEWID() , 'Alisander Sibbons');
insert into employeesName( id , Name ) values ( NEWID() , 'Robbert Ferro');
insert into employeesName( id , Name ) values ( NEWID() , 'Renato Tresise');
insert into employeesName( id , Name ) values ( NEWID() , 'Nertie Ashcroft');
insert into employeesName( id , Name ) values ( NEWID() , 'Albina Merfin');
insert into employeesName( id , Name ) values ( NEWID() , 'Jillie Maitland');
insert into employeesName( id , Name ) values ( NEWID() , 'Elliott Lapsley');
insert into employeesName( id , Name ) values ( NEWID() , 'Marcellus Duffett');
insert into employeesName( id , Name ) values ( NEWID() , 'Onfre Timmons');
insert into employeesName( id , Name ) values ( NEWID() , 'Fianna Jouannisson');
insert into employeesName( id , Name ) values ( NEWID() , 'Catlee Olding');
insert into employeesName( id , Name ) values ( NEWID() , 'Linette Stalf');
insert into employeesName( id , Name ) values ( NEWID() , 'Dom Mackrell');
insert into employeesName( id , Name ) values ( NEWID() , 'Parrnell Pedler');
insert into employeesName( id , Name ) values ( NEWID() , 'Mandie Muscat');
insert into employeesName( id , Name ) values ( NEWID() , 'Jillana Ovett');
insert into employeesName( id , Name ) values ( NEWID() , 'Angy McIlwraith');
insert into employeesName( id , Name ) values ( NEWID() , 'Martynne Cecchi');
insert into employeesName( id , Name ) values ( NEWID() , 'Raquela Clougher');
insert into employeesName( id , Name ) values ( NEWID() , 'Wynn Lippiatt');
insert into employeesName( id , Name ) values ( NEWID() , 'Sig Shailer');
insert into employeesName( id , Name ) values ( NEWID() , 'Gonzalo Tulip');
insert into employeesName( id , Name ) values ( NEWID() , 'Eirena Rosten');
insert into employeesName( id , Name ) values ( NEWID() , 'Jasmina Ace');
insert into employeesName( id , Name ) values ( NEWID() , 'Eduino Lethbridge');
insert into employeesName( id , Name ) values ( NEWID() , 'Lucius Causey');
insert into employeesName( id , Name ) values ( NEWID() , 'Alley Lipmann');
insert into employeesName( id , Name ) values ( NEWID() , 'Sybyl Wayt');
insert into employeesName( id , Name ) values ( NEWID() , 'Austine Beever');
insert into employeesName( id , Name ) values ( NEWID() , 'Nydia Dorsey');
insert into employeesName( id , Name ) values ( NEWID() , 'Frieda Leaning');
insert into employeesName( id , Name ) values ( NEWID() , 'Augustine Bransden');
insert into employeesName( id , Name ) values ( NEWID() , 'Lombard Andrysek');
insert into employeesName( id , Name ) values ( NEWID() , 'Berke Rotter');
insert into employeesName( id , Name ) values ( NEWID() , 'Reggi Barus');
insert into employeesName( id , Name ) values ( NEWID() , 'Karlene Grocock');
insert into employeesName( id , Name ) values ( NEWID() , 'Miquela Jirusek');
insert into employeesName( id , Name ) values ( NEWID() , 'Sigismundo Ibberson');
insert into employeesName( id , Name ) values ( NEWID() , 'Irene Coll');
insert into employeesName( id , Name ) values ( NEWID() , 'Catherina MacVicar');
insert into employeesName( id , Name ) values ( NEWID() , 'Claudian Espinel');
insert into employeesName( id , Name ) values ( NEWID() , 'Linda Sanderson');
insert into employeesName( id , Name ) values ( NEWID() , 'Denny Dashkovich');
insert into employeesName( id , Name ) values ( NEWID() , 'Hendrick Al Hirsi');
insert into employeesName( id , Name ) values ( NEWID() , 'Dorene Hayman');
insert into employeesName( id , Name ) values ( NEWID() , 'Jobie Rice');
insert into employeesName( id , Name ) values ( NEWID() , 'Pooh Bee');
insert into employeesName( id , Name ) values ( NEWID() , 'Darby Trudgian');
insert into employeesName( id , Name ) values ( NEWID() , 'Reggis Teulier');
insert into employeesName( id , Name ) values ( NEWID() , 'Neddie Lippiett');
insert into employeesName( id , Name ) values ( NEWID() , 'Thacher Stackbridge');
insert into employeesName( id , Name ) values ( NEWID() , 'Onfroi Wiggall');
insert into employeesName( id , Name ) values ( NEWID() , 'Nannie Leyfield');
insert into employeesName( id , Name ) values ( NEWID() , 'Alvinia Woodage');
insert into employeesName( id , Name ) values ( NEWID() , 'Krystyna Baumann');
insert into employeesName( id , Name ) values ( NEWID() , 'Lissa Estcourt');
insert into employeesName( id , Name ) values ( NEWID() , 'Kerry Dunbobin');
insert into employeesName( id , Name ) values ( NEWID() , 'Abram Farragher');
insert into employeesName( id , Name ) values ( NEWID() , 'Adolph Nicklinson');
insert into employeesName( id , Name ) values ( NEWID() , 'Melany Galvin');
insert into employeesName( id , Name ) values ( NEWID() , 'Corabel Pavlenkov');
insert into employeesName( id , Name ) values ( NEWID() , 'Nerte Coverley');
insert into employeesName( id , Name ) values ( NEWID() , 'Fina Woolens');
insert into employeesName( id , Name ) values ( NEWID() , 'Eberto Nassey');
insert into employeesName( id , Name ) values ( NEWID() , 'Zed Heaton');
insert into employeesName( id , Name ) values ( NEWID() , 'Malinda Gendricke');
insert into employeesName( id , Name ) values ( NEWID() , 'Patrice Dandy');
insert into employeesName( id , Name ) values ( NEWID() , 'Aimil Clair');
insert into employeesName( id , Name ) values ( NEWID() , 'Lelia Urey');
insert into employeesName( id , Name ) values ( NEWID() , 'Hadrian O''Corr');
insert into employeesName( id , Name ) values ( NEWID() , 'Phyllis Lampens');
insert into employeesName( id , Name ) values ( NEWID() , 'Meryl Baguley');
insert into employeesName( id , Name ) values ( NEWID() , 'Kendall Mutch');
insert into employeesName( id , Name ) values ( NEWID() , 'Barbaraanne Christophersen');
insert into employeesName( id , Name ) values ( NEWID() , 'Dani Riedel');
insert into employeesName( id , Name ) values ( NEWID() , 'Zack Wilce');
insert into employeesName( id , Name ) values ( NEWID() , 'Darya Sponer');
insert into employeesName( id , Name ) values ( NEWID() , 'Hebert Reinert');
insert into employeesName( id , Name ) values ( NEWID() , 'Marley Fiddiman');
insert into employeesName( id , Name ) values ( NEWID() , 'Noe Stracey');
insert into employeesName( id , Name ) values ( NEWID() , 'Gabi Duffil');
insert into employeesName( id , Name ) values ( NEWID() , 'Danette Gallier');
insert into employeesName( id , Name ) values ( NEWID() , 'Laverna Laybourn');
insert into employeesName( id , Name ) values ( NEWID() , 'Gavin Giraldon');
insert into employeesName( id , Name ) values ( NEWID() , 'Beniamino Lockhead');
insert into employeesName( id , Name ) values ( NEWID() , 'Rafaello Jacqueme');
insert into employeesName( id , Name ) values ( NEWID() , 'Gregoor MacMillan');
insert into employeesName( id , Name ) values ( NEWID() , 'Giorgio Rackam');
insert into employeesName( id , Name ) values ( NEWID() , 'Gabbie Domoni');
insert into employeesName( id , Name ) values ( NEWID() , 'Hartley Barroux');
insert into employeesName( id , Name ) values ( NEWID() , 'Ty Dutteridge');
insert into employeesName( id , Name ) values ( NEWID() , 'Cassandra Carriage');
insert into employeesName( id , Name ) values ( NEWID() , 'Cathi Dobrovolny');
insert into employeesName( id , Name ) values ( NEWID() , 'Benedict Munnis');
insert into employeesName( id , Name ) values ( NEWID() , 'Anya Kienzle');
insert into employeesName( id , Name ) values ( NEWID() , 'Mufinella Clowney');
insert into employeesName( id , Name ) values ( NEWID() , 'Christoph Ouldcott');
insert into employeesName( id , Name ) values ( NEWID() , 'Amalle Tilston');
insert into employeesName( id , Name ) values ( NEWID() , 'Thornton Henlon');
insert into employeesName( id , Name ) values ( NEWID() , 'Ranice Gerardi');
insert into employeesName( id , Name ) values ( NEWID() , 'Yolanthe Hinkes');
insert into employeesName( id , Name ) values ( NEWID() , 'Sula Scowen');
insert into employeesName( id , Name ) values ( NEWID() , 'Constancy Clarabut');
insert into employeesName( id , Name ) values ( NEWID() , 'Blythe Pedrick');
insert into employeesName( id , Name ) values ( NEWID() , 'Corliss Byrch');
insert into employeesName( id , Name ) values ( NEWID() , 'Windy Bollin');
insert into employeesName( id , Name ) values ( NEWID() , 'Lewie Snashall');
insert into employeesName( id , Name ) values ( NEWID() , 'Helenelizabeth Ida');
insert into employeesName( id , Name ) values ( NEWID() , 'Gussy Devote');
insert into employeesName( id , Name ) values ( NEWID() , 'Piggy Callender');
insert into employeesName( id , Name ) values ( NEWID() , 'Candida Tambling');
insert into employeesName( id , Name ) values ( NEWID() , 'Guillema Pharaoh');
insert into employeesName( id , Name ) values ( NEWID() , 'Jody Duffell');
insert into employeesName( id , Name ) values ( NEWID() , 'Beatrix Cornes');
insert into employeesName( id , Name ) values ( NEWID() , 'Shantee Merkel');
insert into employeesName( id , Name ) values ( NEWID() , 'Silvio Coling');
insert into employeesName( id , Name ) values ( NEWID() , 'Ginger Crownshaw');
insert into employeesName( id , Name ) values ( NEWID() , 'Erl Mathieu');
insert into employeesName( id , Name ) values ( NEWID() , 'Sybille Lashley');
insert into employeesName( id , Name ) values ( NEWID() , 'Alvinia Knibb');
insert into employeesName( id , Name ) values ( NEWID() , 'Zacharia Chadwen');
insert into employeesName( id , Name ) values ( NEWID() , 'Sherie Goldie');
insert into employeesName( id , Name ) values ( NEWID() , 'Marty McCaig');
insert into employeesName( id , Name ) values ( NEWID() , 'Dolph Isacoff');
insert into employeesName( id , Name ) values ( NEWID() , 'Drusie Toolan');
insert into employeesName( id , Name ) values ( NEWID() , 'Philippine Moxon');
insert into employeesName( id , Name ) values ( NEWID() , 'Marlo Shernock');
insert into employeesName( id , Name ) values ( NEWID() , 'Marne Wharton');
insert into employeesName( id , Name ) values ( NEWID() , 'Kalie Glendza');
insert into employeesName( id , Name ) values ( NEWID() , 'Christean Stonebanks');
insert into employeesName( id , Name ) values ( NEWID() , 'Rey Scotchforth');
insert into employeesName( id , Name ) values ( NEWID() , 'Phyllys Leary');
insert into employeesName( id , Name ) values ( NEWID() , 'Desiri Raspin');
insert into employeesName( id , Name ) values ( NEWID() , 'Gretta Jobbins');
insert into employeesName( id , Name ) values ( NEWID() , 'Patrizio Coverly');
insert into employeesName( id , Name ) values ( NEWID() , 'Leontine Stanlock');
insert into employeesName( id , Name ) values ( NEWID() , 'Hewet Pampling');
insert into employeesName( id , Name ) values ( NEWID() , 'Bartel Greder');
insert into employeesName( id , Name ) values ( NEWID() , 'Phyllys Ellard');
insert into employeesName( id , Name ) values ( NEWID() , 'Modesty Warsap');
insert into employeesName( id , Name ) values ( NEWID() , 'Hogan Rolfi');
insert into employeesName( id , Name ) values ( NEWID() , 'Cherey Sherwen');
insert into employeesName( id , Name ) values ( NEWID() , 'Robinson McInnes');
insert into employeesName( id , Name ) values ( NEWID() , 'Bonnie Matskiv');
insert into employeesName( id , Name ) values ( NEWID() , 'Aeriell Housby');
insert into employeesName( id , Name ) values ( NEWID() , 'Conny Fitzmaurice');
insert into employeesName( id , Name ) values ( NEWID() , 'Corissa Bartolomeazzi');
insert into employeesName( id , Name ) values ( NEWID() , 'Shannan Waters');
insert into employeesName( id , Name ) values ( NEWID() , 'Alyse Beynon');
insert into employeesName( id , Name ) values ( NEWID() , 'Jaye Odo');
insert into employeesName( id , Name ) values ( NEWID() , 'Cleon Margram');
insert into employeesName( id , Name ) values ( NEWID() , 'Danyette Shipton');
insert into employeesName( id , Name ) values ( NEWID() , 'Beverly Cleife');
insert into employeesName( id , Name ) values ( NEWID() , 'Durward D''Alesio');
insert into employeesName( id , Name ) values ( NEWID() , 'Catha Andrey');
insert into employeesName( id , Name ) values ( NEWID() , 'Maureene Boyle');
insert into employeesName( id , Name ) values ( NEWID() , 'Inna Beels');
insert into employeesName( id , Name ) values ( NEWID() , 'Jan Godsil');
insert into employeesName( id , Name ) values ( NEWID() , 'Kelly Bissiker');
insert into employeesName( id , Name ) values ( NEWID() , 'Angie Musla');
insert into employeesName( id , Name ) values ( NEWID() , 'Angelia Pentycross');
insert into employeesName( id , Name ) values ( NEWID() , 'Leah Wooffitt');
insert into employeesName( id , Name ) values ( NEWID() , 'Florette Spoor');
insert into employeesName( id , Name ) values ( NEWID() , 'Hayyim Stonhewer');
insert into employeesName( id , Name ) values ( NEWID() , 'Rutger Samter');
insert into employeesName( id , Name ) values ( NEWID() , 'Heall Hutchison');
insert into employeesName( id , Name ) values ( NEWID() , 'Carree Dowbekin');
insert into employeesName( id , Name ) values ( NEWID() , 'Opalina Sawfoot');
insert into employeesName( id , Name ) values ( NEWID() , 'Ashely Olligan');
insert into employeesName( id , Name ) values ( NEWID() , 'Ruthe McCleod');
insert into employeesName( id , Name ) values ( NEWID() , 'Konrad Lorenzo');
insert into employeesName( id , Name ) values ( NEWID() , 'Pepe Mesnard');
insert into employeesName( id , Name ) values ( NEWID() , 'Biddy Adcock');
insert into employeesName( id , Name ) values ( NEWID() , 'Persis Kryzhov');
insert into employeesName( id , Name ) values ( NEWID() , 'Babs Labat');
insert into employeesName( id , Name ) values ( NEWID() , 'Killy Geertje');
insert into employeesName( id , Name ) values ( NEWID() , 'Odelle Prudham');
insert into employeesName( id , Name ) values ( NEWID() , 'Norman Castan');
insert into employeesName( id , Name ) values ( NEWID() , 'Lynett Yaakov');
insert into employeesName( id , Name ) values ( NEWID() , 'Kelcey Patley');
insert into employeesName( id , Name ) values ( NEWID() , 'Linnea Trevett');
insert into employeesName( id , Name ) values ( NEWID() , 'Vaughn Pendock');
insert into employeesName( id , Name ) values ( NEWID() , 'Wyatt Teodori');
insert into employeesName( id , Name ) values ( NEWID() , 'Kerstin Creaney');
insert into employeesName( id , Name ) values ( NEWID() , 'Leanora Ungaretti');
insert into employeesName( id , Name ) values ( NEWID() , 'Augusto Grayshan');
insert into employeesName( id , Name ) values ( NEWID() , 'Collen Mea');
insert into employeesName( id , Name ) values ( NEWID() , 'Kathi Sleight');
insert into employeesName( id , Name ) values ( NEWID() , 'Charmine Havers');
insert into employeesName( id , Name ) values ( NEWID() , 'Mirelle Micheu');
insert into employeesName( id , Name ) values ( NEWID() , 'Josee Hain');
insert into employeesName( id , Name ) values ( NEWID() , 'Hetty Porter');
insert into employeesName( id , Name ) values ( NEWID() , 'Oswald Barson');
insert into employeesName( id , Name ) values ( NEWID() , 'Leroi King');
insert into employeesName( id , Name ) values ( NEWID() , 'Andie Leyton');
insert into employeesName( id , Name ) values ( NEWID() , 'Kathie Bangham');
insert into employeesName( id , Name ) values ( NEWID() , 'Antonius MacKnockiter');
insert into employeesName( id , Name ) values ( NEWID() , 'Sadie Rodrigo');
insert into employeesName( id , Name ) values ( NEWID() , 'Lauri Thirlwell');
insert into employeesName( id , Name ) values ( NEWID() , 'Justus Galero');
insert into employeesName( id , Name ) values ( NEWID() , 'Jimmie Conaboy');
insert into employeesName( id , Name ) values ( NEWID() , 'Margery Shepton');
insert into employeesName( id , Name ) values ( NEWID() , 'Amara Pehrsson');
insert into employeesName( id , Name ) values ( NEWID() , 'Tabb De Benedictis');
insert into employeesName( id , Name ) values ( NEWID() , 'Ajay Offill');
insert into employeesName( id , Name ) values ( NEWID() , 'Ossie Archanbault');
insert into employeesName( id , Name ) values ( NEWID() , 'Marcelline Gorman');
insert into employeesName( id , Name ) values ( NEWID() , 'Elsie Bellanger');
insert into employeesName( id , Name ) values ( NEWID() , 'Aurilia Yokel');
insert into employeesName( id , Name ) values ( NEWID() , 'Leslie Matyashev');
insert into employeesName( id , Name ) values ( NEWID() , 'Erica Slowgrove');
insert into employeesName( id , Name ) values ( NEWID() , 'Ambros Mallord');
insert into employeesName( id , Name ) values ( NEWID() , 'Aeriel Kann');
insert into employeesName( id , Name ) values ( NEWID() , 'Stefania Rampling');
insert into employeesName( id , Name ) values ( NEWID() , 'Ambrosius Grayshon');
insert into employeesName( id , Name ) values ( NEWID() , 'Shelley Birtwistle');
insert into employeesName( id , Name ) values ( NEWID() , 'Reine MacLachlan');
insert into employeesName( id , Name ) values ( NEWID() , 'Stavros Targetter');
insert into employeesName( id , Name ) values ( NEWID() , 'Jonathan Juszczyk');
insert into employeesName( id , Name ) values ( NEWID() , 'Abigail Sawley');
insert into employeesName( id , Name ) values ( NEWID() , 'Helenka Sims');
insert into employeesName( id , Name ) values ( NEWID() , 'Regina Olkowicz');
insert into employeesName( id , Name ) values ( NEWID() , 'Alexandra Fluger');
insert into employeesName( id , Name ) values ( NEWID() , 'Chickie Pheazey');
insert into employeesName( id , Name ) values ( NEWID() , 'Cloe Egel');
insert into employeesName( id , Name ) values ( NEWID() , 'Silvie McInnerny');
insert into employeesName( id , Name ) values ( NEWID() , 'Chet Hardaway');
insert into employeesName( id , Name ) values ( NEWID() , 'Winona Kefford');
insert into employeesName( id , Name ) values ( NEWID() , 'Chelsea Momford');
insert into employeesName( id , Name ) values ( NEWID() , 'Evey Gonzalo');
insert into employeesName( id , Name ) values ( NEWID() , 'Isidore Cruwys');
insert into employeesName( id , Name ) values ( NEWID() , 'Panchito Buckston');
insert into employeesName( id , Name ) values ( NEWID() , 'Skell Beddingham');
insert into employeesName( id , Name ) values ( NEWID() , 'Clifford Pethick');
insert into employeesName( id , Name ) values ( NEWID() , 'Rayna Padson');
insert into employeesName( id , Name ) values ( NEWID() , 'Amalea Beveredge');
insert into employeesName( id , Name ) values ( NEWID() , 'Gae Jesson');
insert into employeesName( id , Name ) values ( NEWID() , 'Monty Turtle');
insert into employeesName( id , Name ) values ( NEWID() , 'Preston Roz');
insert into employeesName( id , Name ) values ( NEWID() , 'Wilbert Balshaw');
insert into employeesName( id , Name ) values ( NEWID() , 'Elita Drewe');
insert into employeesName( id , Name ) values ( NEWID() , 'Cecile Gardner');
insert into employeesName( id , Name ) values ( NEWID() , 'Alexa Doram');
insert into employeesName( id , Name ) values ( NEWID() , 'Bronny Storie');
insert into employeesName( id , Name ) values ( NEWID() , 'Don Tinson');
insert into employeesName( id , Name ) values ( NEWID() , 'Demetre Clapton');
insert into employeesName( id , Name ) values ( NEWID() , 'Dido Benzi');
insert into employeesName( id , Name ) values ( NEWID() , 'Jayson Casado');
insert into employeesName( id , Name ) values ( NEWID() , 'Thaddeus McIlwain');
insert into employeesName( id , Name ) values ( NEWID() , 'Jaclin Emor');
insert into employeesName( id , Name ) values ( NEWID() , 'Camel Peschka');
insert into employeesName( id , Name ) values ( NEWID() , 'Dalenna Lebourn');
insert into employeesName( id , Name ) values ( NEWID() , 'Doreen Germann');
insert into employeesName( id , Name ) values ( NEWID() , 'Gerard Brok');
insert into employeesName( id , Name ) values ( NEWID() , 'Sharyl Blesli');
insert into employeesName( id , Name ) values ( NEWID() , 'Gav Gwillim');
insert into employeesName( id , Name ) values ( NEWID() , 'Simonette MacKellen');
insert into employeesName( id , Name ) values ( NEWID() , 'Abbi Medford');
insert into employeesName( id , Name ) values ( NEWID() , 'Aeriell Wolpert');
insert into employeesName( id , Name ) values ( NEWID() , 'Elly Tschiersch');
insert into employeesName( id , Name ) values ( NEWID() , 'Ario Daviot');
insert into employeesName( id , Name ) values ( NEWID() , 'Bartholemy Keyzman');
insert into employeesName( id , Name ) values ( NEWID() , 'Emlynn Sargant');
insert into employeesName( id , Name ) values ( NEWID() , 'Toby Askin');
insert into employeesName( id , Name ) values ( NEWID() , 'Gratiana Westbury');
insert into employeesName( id , Name ) values ( NEWID() , 'Neall Franz-Schoninger');
insert into employeesName( id , Name ) values ( NEWID() , 'Kaye Lundbeck');
insert into employeesName( id , Name ) values ( NEWID() , 'Chiquita Stanyard');
insert into employeesName( id , Name ) values ( NEWID() , 'Emili Brewers');
insert into employeesName( id , Name ) values ( NEWID() , 'Yale Doleman');
insert into employeesName( id , Name ) values ( NEWID() , 'Alberik Mizen');
insert into employeesName( id , Name ) values ( NEWID() , 'Janice MacClure');
insert into employeesName( id , Name ) values ( NEWID() , 'Dominic Foulks');
insert into employeesName( id , Name ) values ( NEWID() , 'Casper Gaffey');
insert into employeesName( id , Name ) values ( NEWID() , 'Lanny Sankey');
insert into employeesName( id , Name ) values ( NEWID() , 'Natalie Eplett');
insert into employeesName( id , Name ) values ( NEWID() , 'Tobias Bilby');
insert into employeesName( id , Name ) values ( NEWID() , 'Eugenio MacIver');
insert into employeesName( id , Name ) values ( NEWID() , 'Noam Van Velden');
insert into employeesName( id , Name ) values ( NEWID() , 'Sharona McAlester');
insert into employeesName( id , Name ) values ( NEWID() , 'Estel Boc');
insert into employeesName( id , Name ) values ( NEWID() , 'Robinia Houseman');
insert into employeesName( id , Name ) values ( NEWID() , 'Alden Conant');
insert into employeesName( id , Name ) values ( NEWID() , 'Lilith Duck');
insert into employeesName( id , Name ) values ( NEWID() , 'Winnah Schettini');
insert into employeesName( id , Name ) values ( NEWID() , 'Gates Tregenza');
insert into employeesName( id , Name ) values ( NEWID() , 'Aridatha Sangwin');
insert into employeesName( id , Name ) values ( NEWID() , 'Bradney Broske');
insert into employeesName( id , Name ) values ( NEWID() , 'Shel Waddam');
insert into employeesName( id , Name ) values ( NEWID() , 'Jemima Samwyse');
insert into employeesName( id , Name ) values ( NEWID() , 'Reinaldo Crawcour');
insert into employeesName( id , Name ) values ( NEWID() , 'Fifine Easlea');
insert into employeesName( id , Name ) values ( NEWID() , 'Raff Rowbrey');
insert into employeesName( id , Name ) values ( NEWID() , 'Cleavland Goldthorp');
insert into employeesName( id , Name ) values ( NEWID() , 'Gwendolyn Kees');
insert into employeesName( id , Name ) values ( NEWID() , 'Roarke Edrich');
insert into employeesName( id , Name ) values ( NEWID() , 'Hannie Hail');
insert into employeesName( id , Name ) values ( NEWID() , 'Robbi Duro');
insert into employeesName( id , Name ) values ( NEWID() , 'Porty Leber');
insert into employeesName( id , Name ) values ( NEWID() , 'Ingram Cardenoza');
insert into employeesName( id , Name ) values ( NEWID() , 'Mira McGeneay');
insert into employeesName( id , Name ) values ( NEWID() , 'Homer Kensington');
insert into employeesName( id , Name ) values ( NEWID() , 'Veradis Stonard');
insert into employeesName( id , Name ) values ( NEWID() , 'Alicea Clifforth');
insert into employeesName( id , Name ) values ( NEWID() , 'Hannah Bellward');
insert into employeesName( id , Name ) values ( NEWID() , 'Chrisy Peirpoint');
insert into employeesName( id , Name ) values ( NEWID() , 'Angil Sturgess');
insert into employeesName( id , Name ) values ( NEWID() , 'Kristine Membry');
insert into employeesName( id , Name ) values ( NEWID() , 'Corliss Fonquernie');
insert into employeesName( id , Name ) values ( NEWID() , 'Rhona Leney');
insert into employeesName( id , Name ) values ( NEWID() , 'Doy Ivanets');
insert into employeesName( id , Name ) values ( NEWID() , 'Miller Hegden');
insert into employeesName( id , Name ) values ( NEWID() , 'Kaile Whanstall');
insert into employeesName( id , Name ) values ( NEWID() , 'Kellina Kingcote');
insert into employeesName( id , Name ) values ( NEWID() , 'Tish Chasmer');
insert into employeesName( id , Name ) values ( NEWID() , 'Rheba Smeaton');
insert into employeesName( id , Name ) values ( NEWID() , 'El Hillyatt');
insert into employeesName( id , Name ) values ( NEWID() , 'Carlynne Merit');
insert into employeesName( id , Name ) values ( NEWID() , 'Antonietta Candelin');
insert into employeesName( id , Name ) values ( NEWID() , 'Patty Carlow');
insert into employeesName( id , Name ) values ( NEWID() , 'Sigismund Prettyman');
insert into employeesName( id , Name ) values ( NEWID() , 'Artemis Greenroad');
insert into employeesName( id , Name ) values ( NEWID() , 'Florance Brewett');
insert into employeesName( id , Name ) values ( NEWID() , 'Sherri Jojic');
insert into employeesName( id , Name ) values ( NEWID() , 'Freddie Vedstra');
insert into employeesName( id , Name ) values ( NEWID() , 'Gregoor Beeson');
insert into employeesName( id , Name ) values ( NEWID() , 'Elwood Donati');
insert into employeesName( id , Name ) values ( NEWID() , 'Paquito Jarratt');
insert into employeesName( id , Name ) values ( NEWID() , 'Aguie Willbourne');
insert into employeesName( id , Name ) values ( NEWID() , 'Rochell Bithell');
insert into employeesName( id , Name ) values ( NEWID() , 'Zondra Hargess');
insert into employeesName( id , Name ) values ( NEWID() , 'Palm Huncoot');
insert into employeesName( id , Name ) values ( NEWID() , 'Ellette Slevin');
insert into employeesName( id , Name ) values ( NEWID() , 'Renelle Tibald');
insert into employeesName( id , Name ) values ( NEWID() , 'Robinson Clohissy');
insert into employeesName( id , Name ) values ( NEWID() , 'Karlan Plomer');
insert into employeesName( id , Name ) values ( NEWID() , 'Sonya Oene');
insert into employeesName( id , Name ) values ( NEWID() , 'Margie Dungate');
insert into employeesName( id , Name ) values ( NEWID() , 'Karee Godfree');
insert into employeesName( id , Name ) values ( NEWID() , 'Jared Pestor');
insert into employeesName( id , Name ) values ( NEWID() , 'Martina Dudson');
insert into employeesName( id , Name ) values ( NEWID() , 'Miran Edmed');
insert into employeesName( id , Name ) values ( NEWID() , 'Kareem Winley');
insert into employeesName( id , Name ) values ( NEWID() , 'Eleonora Marlen');
insert into employeesName( id , Name ) values ( NEWID() , 'Silvana Snarie');
insert into employeesName( id , Name ) values ( NEWID() , 'Hal Deinhardt');
insert into employeesName( id , Name ) values ( NEWID() , 'Ella Rizzello');
insert into employeesName( id , Name ) values ( NEWID() , 'Lotti Dudbridge');
insert into employeesName( id , Name ) values ( NEWID() , 'Purcell Pledger');
insert into employeesName( id , Name ) values ( NEWID() , 'Berton Burkhill');
insert into employeesName( id , Name ) values ( NEWID() , 'Sigfried Peeke-Vout');
insert into employeesName( id , Name ) values ( NEWID() , 'Merilee Mc Combe');
insert into employeesName( id , Name ) values ( NEWID() , 'Maxy Haggis');
insert into employeesName( id , Name ) values ( NEWID() , 'Ruben Tohill');
insert into employeesName( id , Name ) values ( NEWID() , 'Conroy Coverdill');
insert into employeesName( id , Name ) values ( NEWID() , 'Belinda Hatzar');
insert into employeesName( id , Name ) values ( NEWID() , 'Lacee Tear');
insert into employeesName( id , Name ) values ( NEWID() , 'Heddie Hooban');
insert into employeesName( id , Name ) values ( NEWID() , 'Chan Farquharson');
insert into employeesName( id , Name ) values ( NEWID() , 'Morse Dmitr');
insert into employeesName( id , Name ) values ( NEWID() , 'Eve Dark');
insert into employeesName( id , Name ) values ( NEWID() , 'Mallorie Treacy');
insert into employeesName( id , Name ) values ( NEWID() , 'Matty Stroder');
insert into employeesName( id , Name ) values ( NEWID() , 'Nedi Hamlington');
insert into employeesName( id , Name ) values ( NEWID() , 'Ludovico Bloomfield');
insert into employeesName( id , Name ) values ( NEWID() , 'Tanny Weymouth');
insert into employeesName( id , Name ) values ( NEWID() , 'Jessalin Cornelius');
insert into employeesName( id , Name ) values ( NEWID() , 'Mata Dungey');
insert into employeesName( id , Name ) values ( NEWID() , 'Lorne Kellar');
insert into employeesName( id , Name ) values ( NEWID() , 'Nikolas Martinello');
insert into employeesName( id , Name ) values ( NEWID() , 'Claretta McIndrew');
insert into employeesName( id , Name ) values ( NEWID() , 'Lane Klebes');
insert into employeesName( id , Name ) values ( NEWID() , 'Johannes Mangeney');
insert into employeesName( id , Name ) values ( NEWID() , 'Brocky Mum');
insert into employeesName( id , Name ) values ( NEWID() , 'Margarette Piatto');
insert into employeesName( id , Name ) values ( NEWID() , 'Christopher Struttman');
insert into employeesName( id , Name ) values ( NEWID() , 'Murvyn Bedding');
insert into employeesName( id , Name ) values ( NEWID() , 'Cthrine Collingworth');
insert into employeesName( id , Name ) values ( NEWID() , 'Natalie Laingmaid');
insert into employeesName( id , Name ) values ( NEWID() , 'Kattie Bromby');
insert into employeesName( id , Name ) values ( NEWID() , 'Honey Kilmister');
insert into employeesName( id , Name ) values ( NEWID() , 'Salomo Pelchat');
insert into employeesName( id , Name ) values ( NEWID() , 'Alika Claypoole');
insert into employeesName( id , Name ) values ( NEWID() , 'Purcell Dunkersley');
insert into employeesName( id , Name ) values ( NEWID() , 'Isac Henken');
insert into employeesName( id , Name ) values ( NEWID() , 'Felic Baldelli');
insert into employeesName( id , Name ) values ( NEWID() , 'Hashim Abdon');
insert into employeesName( id , Name ) values ( NEWID() , 'Kory Anderton');
insert into employeesName( id , Name ) values ( NEWID() , 'Milzie Ledgister');
insert into employeesName( id , Name ) values ( NEWID() , 'Tom Garrish');
insert into employeesName( id , Name ) values ( NEWID() , 'Barbra Berresford');
insert into employeesName( id , Name ) values ( NEWID() , 'Steven Reddyhoff');
insert into employeesName( id , Name ) values ( NEWID() , 'Kay Barde');
insert into employeesName( id , Name ) values ( NEWID() , 'Miguelita Jubert');
insert into employeesName( id , Name ) values ( NEWID() , 'Bellanca Saddington');
insert into employeesName( id , Name ) values ( NEWID() , 'Miquela Goatcher');
insert into employeesName( id , Name ) values ( NEWID() , 'Ortensia Alben');
insert into employeesName( id , Name ) values ( NEWID() , 'Delmar Grocock');
insert into employeesName( id , Name ) values ( NEWID() , 'Laina Bulch');
insert into employeesName( id , Name ) values ( NEWID() , 'Dwight Caghy');
insert into employeesName( id , Name ) values ( NEWID() , 'Remington Gallagher');
insert into employeesName( id , Name ) values ( NEWID() , 'Ida Johnston');
insert into employeesName( id , Name ) values ( NEWID() , 'Fernanda Francais');
insert into employeesName( id , Name ) values ( NEWID() , 'Krista Bytheway');
insert into employeesName( id , Name ) values ( NEWID() , 'Maurizia Dinesen');
insert into employeesName( id , Name ) values ( NEWID() , 'Sinclare Tackle');
insert into employeesName( id , Name ) values ( NEWID() , 'Adriaens McNirlan');
insert into employeesName( id , Name ) values ( NEWID() , 'Kerrie Whodcoat');
insert into employeesName( id , Name ) values ( NEWID() , 'Andres Durston');
insert into employeesName( id , Name ) values ( NEWID() , 'Missie Klimes');
insert into employeesName( id , Name ) values ( NEWID() , 'Sammy Lambden');
insert into employeesName( id , Name ) values ( NEWID() , 'Rourke Honeywood');
insert into employeesName( id , Name ) values ( NEWID() , 'Brana Gook');
insert into employeesName( id , Name ) values ( NEWID() , 'Jocelyne Rohlfs');
insert into employeesName( id , Name ) values ( NEWID() , 'Lonee Gregorio');
insert into employeesName( id , Name ) values ( NEWID() , 'Mayor Placidi');
insert into employeesName( id , Name ) values ( NEWID() , 'Casi Letertre');
insert into employeesName( id , Name ) values ( NEWID() , 'Moyna Caswall');
insert into employeesName( id , Name ) values ( NEWID() , 'Tarrah Branscombe');
insert into employeesName( id , Name ) values ( NEWID() , 'Sher Coppins');
insert into employeesName( id , Name ) values ( NEWID() , 'Wilton Knox');
insert into employeesName( id , Name ) values ( NEWID() , 'Hamlen Fields');
insert into employeesName( id , Name ) values ( NEWID() , 'Purcell Gullane');
insert into employeesName( id , Name ) values ( NEWID() , 'Benedicta Clemmey');
insert into employeesName( id , Name ) values ( NEWID() , 'Hali Bartosinski');
insert into employeesName( id , Name ) values ( NEWID() , 'Brade Castanho');
insert into employeesName( id , Name ) values ( NEWID() , 'De witt Hancell');
insert into employeesName( id , Name ) values ( NEWID() , 'Bax Doget');
insert into employeesName( id , Name ) values ( NEWID() , 'Arlen Grund');
insert into employeesName( id , Name ) values ( NEWID() , 'Malvin Dayes');
insert into employeesName( id , Name ) values ( NEWID() , 'Hew Cantopher');
insert into employeesName( id , Name ) values ( NEWID() , 'Nicolis Castillou');
insert into employeesName( id , Name ) values ( NEWID() , 'Orran Pettie');
insert into employeesName( id , Name ) values ( NEWID() , 'Mickey Denton');
insert into employeesName( id , Name ) values ( NEWID() , 'Sergei Garstang');
insert into employeesName( id , Name ) values ( NEWID() , 'Lars Finnes');
insert into employeesName( id , Name ) values ( NEWID() , 'Carce Gherardi');
insert into employeesName( id , Name ) values ( NEWID() , 'Berton Watkiss');
insert into employeesName( id , Name ) values ( NEWID() , 'Regan Loeber');
insert into employeesName( id , Name ) values ( NEWID() , 'Torrence Ellwand');
insert into employeesName( id , Name ) values ( NEWID() , 'Lay Yosevitz');
insert into employeesName( id , Name ) values ( NEWID() , 'Vivyanne Frentz');
insert into employeesName( id , Name ) values ( NEWID() , 'Glynda Valentetti');
insert into employeesName( id , Name ) values ( NEWID() , 'Henri Fenkel');
insert into employeesName( id , Name ) values ( NEWID() , 'Cob Abelovitz');
insert into employeesName( id , Name ) values ( NEWID() , 'Desiree Rayment');
insert into employeesName( id , Name ) values ( NEWID() , 'Iain Rennicks');
insert into employeesName( id , Name ) values ( NEWID() , 'Kate Bussen');
insert into employeesName( id , Name ) values ( NEWID() , 'Geri Dionisii');
insert into employeesName( id , Name ) values ( NEWID() , 'Morten Attenborough');
insert into employeesName( id , Name ) values ( NEWID() , 'Chickie Leftley');
insert into employeesName( id , Name ) values ( NEWID() , 'Nanice Yerrall');
insert into employeesName( id , Name ) values ( NEWID() , 'Rollin Cockburn');
insert into employeesName( id , Name ) values ( NEWID() , 'Wittie Grimm');
insert into employeesName( id , Name ) values ( NEWID() , 'Eleonora Hully');
insert into employeesName( id , Name ) values ( NEWID() , 'Bethanne Rebeiro');
insert into employeesName( id , Name ) values ( NEWID() , 'Sigvard Lints');
insert into employeesName( id , Name ) values ( NEWID() , 'Estel Ligoe');
insert into employeesName( id , Name ) values ( NEWID() , 'Barth Randle');
insert into employeesName( id , Name ) values ( NEWID() , 'Randa Chippendale');
insert into employeesName( id , Name ) values ( NEWID() , 'Clint Karsh');
insert into employeesName( id , Name ) values ( NEWID() , 'Rad De Filippo');
insert into employeesName( id , Name ) values ( NEWID() , 'Bernardina Howes');
insert into employeesName( id , Name ) values ( NEWID() , 'Nicole Fincher');
insert into employeesName( id , Name ) values ( NEWID() , 'Caron Blaes');
insert into employeesName( id , Name ) values ( NEWID() , 'Xavier Ruxton');
insert into employeesName( id , Name ) values ( NEWID() , 'Hunfredo Larman');
insert into employeesName( id , Name ) values ( NEWID() , 'Cazzie Torricella');
insert into employeesName( id , Name ) values ( NEWID() , 'Archaimbaud O''Hoolahan');
insert into employeesName( id , Name ) values ( NEWID() , 'Leopold Twinborough');
insert into employeesName( id , Name ) values ( NEWID() , 'Merwyn Twelvetrees');
insert into employeesName( id , Name ) values ( NEWID() , 'Hort Lilliman');
insert into employeesName( id , Name ) values ( NEWID() , 'Miller McGrotty');
insert into employeesName( id , Name ) values ( NEWID() , 'Maddy McBay');
insert into employeesName( id , Name ) values ( NEWID() , 'Antonie Belle');
insert into employeesName( id , Name ) values ( NEWID() , 'Roslyn Hulbert');
insert into employeesName( id , Name ) values ( NEWID() , 'Gian Rault');
insert into employeesName( id , Name ) values ( NEWID() , 'Cora Bailles');
insert into employeesName( id , Name ) values ( NEWID() , 'Catherina Saltsberger');
insert into employeesName( id , Name ) values ( NEWID() , 'Dinny Pietz');
insert into employeesName( id , Name ) values ( NEWID() , 'Trixie Spender');
insert into employeesName( id , Name ) values ( NEWID() , 'Randolf Galway');
insert into employeesName( id , Name ) values ( NEWID() , 'Tara Warrener');
insert into employeesName( id , Name ) values ( NEWID() , 'Lela Murdoch');
insert into employeesName( id , Name ) values ( NEWID() , 'Zitella Pankethman');
insert into employeesName( id , Name ) values ( NEWID() , 'Chip Rosberg');
insert into employeesName( id , Name ) values ( NEWID() , 'Antin Hefforde');
insert into employeesName( id , Name ) values ( NEWID() , 'Vassily Du Hamel');
insert into employeesName( id , Name ) values ( NEWID() , 'Kassi Buntain');
insert into employeesName( id , Name ) values ( NEWID() , 'Evyn Noddings');
insert into employeesName( id , Name ) values ( NEWID() , 'Glenda Laste');
insert into employeesName( id , Name ) values ( NEWID() , 'Casey Tonge');
insert into employeesName( id , Name ) values ( NEWID() , 'Orella McGeachy');
insert into employeesName( id , Name ) values ( NEWID() , 'Kellie Trenfield');
insert into employeesName( id , Name ) values ( NEWID() , 'Salvatore Shipley');
insert into employeesName( id , Name ) values ( NEWID() , 'Laurie Christofides');
insert into employeesName( id , Name ) values ( NEWID() , 'Dion Tregien');
insert into employeesName( id , Name ) values ( NEWID() , 'Abelard Esslement');
insert into employeesName( id , Name ) values ( NEWID() , 'Lyndy Goeff');
insert into employeesName( id , Name ) values ( NEWID() , 'Hazel Loody');
insert into employeesName( id , Name ) values ( NEWID() , 'Gerhard Ryton');
insert into employeesName( id , Name ) values ( NEWID() , 'Garret Rowntree');
insert into employeesName( id , Name ) values ( NEWID() , 'Nester Hamlen');
insert into employeesName( id , Name ) values ( NEWID() , 'Stephannie Grumble');
insert into employeesName( id , Name ) values ( NEWID() , 'Martha Mottinelli');
insert into employeesName( id , Name ) values ( NEWID() , 'Niles Albone');
insert into employeesName( id , Name ) values ( NEWID() , 'Bert Delaney');
insert into employeesName( id , Name ) values ( NEWID() , 'Shalne Tejada');
insert into employeesName( id , Name ) values ( NEWID() , 'Vinnie Demke');
insert into employeesName( id , Name ) values ( NEWID() , 'Byrann Franseco');
insert into employeesName( id , Name ) values ( NEWID() , 'Neddie Runham');
insert into employeesName( id , Name ) values ( NEWID() , 'Hildegarde Upson');
insert into employeesName( id , Name ) values ( NEWID() , 'Alvie Finnis');
insert into employeesName( id , Name ) values ( NEWID() , 'Hillary Dacres');
insert into employeesName( id , Name ) values ( NEWID() , 'Jade Jowling');
insert into employeesName( id , Name ) values ( NEWID() , 'Bret Hounsham');
insert into employeesName( id , Name ) values ( NEWID() , 'Bowie McGavin');
insert into employeesName( id , Name ) values ( NEWID() , 'Meridith Howbrook');
insert into employeesName( id , Name ) values ( NEWID() , 'Hyacinthie Ussher');
insert into employeesName( id , Name ) values ( NEWID() , 'Link Figgures');
insert into employeesName( id , Name ) values ( NEWID() , 'Sander Morrant');
insert into employeesName( id , Name ) values ( NEWID() , 'Vernice Kettlestring');
insert into employeesName( id , Name ) values ( NEWID() , 'Gary Crollman');
insert into employeesName( id , Name ) values ( NEWID() , 'Glenna Darley');
insert into employeesName( id , Name ) values ( NEWID() , 'Goran McMains');
insert into employeesName( id , Name ) values ( NEWID() , 'Ashley Shefton');
insert into employeesName( id , Name ) values ( NEWID() , 'Keven Camolli');
insert into employeesName( id , Name ) values ( NEWID() , 'Corene Tubridy');
insert into employeesName( id , Name ) values ( NEWID() , 'Hephzibah McKintosh');
insert into employeesName( id , Name ) values ( NEWID() , 'Damian Girvan');
insert into employeesName( id , Name ) values ( NEWID() , 'Tamqrah Isgar');
insert into employeesName( id , Name ) values ( NEWID() , 'Rosanna Skyme');
insert into employeesName( id , Name ) values ( NEWID() , 'Meredith Badder');
insert into employeesName( id , Name ) values ( NEWID() , 'Margret Kynaston');
insert into employeesName( id , Name ) values ( NEWID() , 'Maddalena Whittock');
insert into employeesName( id , Name ) values ( NEWID() , 'Larina Woltman');
insert into employeesName( id , Name ) values ( NEWID() , 'Si O''Mullally');
insert into employeesName( id , Name ) values ( NEWID() , 'Ninetta Savatier');
insert into employeesName( id , Name ) values ( NEWID() , 'Aube Pessel');
insert into employeesName( id , Name ) values ( NEWID() , 'Whitby Bontine');
insert into employeesName( id , Name ) values ( NEWID() , 'Joyous Guerreru');
insert into employeesName( id , Name ) values ( NEWID() , 'Jermaine Berzen');
insert into employeesName( id , Name ) values ( NEWID() , 'Nert Mussettini');
insert into employeesName( id , Name ) values ( NEWID() , 'Tandy Brambell');
insert into employeesName( id , Name ) values ( NEWID() , 'Tomkin Crathern');
insert into employeesName( id , Name ) values ( NEWID() , 'Rina Hiers');
insert into employeesName( id , Name ) values ( NEWID() , 'Gussi Frantz');
insert into employeesName( id , Name ) values ( NEWID() , 'Kelley Braferton');
insert into employeesName( id , Name ) values ( NEWID() , 'Antonetta Dalton');
insert into employeesName( id , Name ) values ( NEWID() , 'Chery Tomasz');
insert into employeesName( id , Name ) values ( NEWID() , 'Veronique Hurcombe');
insert into employeesName( id , Name ) values ( NEWID() , 'Hanna Cahani');
insert into employeesName( id , Name ) values ( NEWID() , 'Tynan Toffolo');
insert into employeesName( id , Name ) values ( NEWID() , 'Johna Uzelli');
insert into employeesName( id , Name ) values ( NEWID() , 'Monte Danelut');
insert into employeesName( id , Name ) values ( NEWID() , 'Margot Kilbey');
insert into employeesName( id , Name ) values ( NEWID() , 'Wenonah Tiptaft');
insert into employeesName( id , Name ) values ( NEWID() , 'Dewie Tibbles');
insert into employeesName( id , Name ) values ( NEWID() , 'Kalvin Maggorini');
insert into employeesName( id , Name ) values ( NEWID() , 'Milly Spitaro');
insert into employeesName( id , Name ) values ( NEWID() , 'Katerina Whinray');
insert into employeesName( id , Name ) values ( NEWID() , 'Dominique Bowller');
insert into employeesName( id , Name ) values ( NEWID() , 'Doti Soulsby');
insert into employeesName( id , Name ) values ( NEWID() , 'Berkly Bachmann');
insert into employeesName( id , Name ) values ( NEWID() , 'Milly Macci');
insert into employeesName( id , Name ) values ( NEWID() , 'Amanda Wiltshaw');
insert into employeesName( id , Name ) values ( NEWID() , 'Kermit Skarman');
insert into employeesName( id , Name ) values ( NEWID() , 'Shelby Backes');
insert into employeesName( id , Name ) values ( NEWID() , 'Bernardine Scholey');
insert into employeesName( id , Name ) values ( NEWID() , 'Cecilia Gonnelly');
insert into employeesName( id , Name ) values ( NEWID() , 'Jerrylee Baudasso');
insert into employeesName( id , Name ) values ( NEWID() , 'Fleurette Medhurst');
insert into employeesName( id , Name ) values ( NEWID() , 'Edita Rimer');
insert into employeesName( id , Name ) values ( NEWID() , 'Dawn Deadman');
insert into employeesName( id , Name ) values ( NEWID() , 'Maximilien Djordjevic');
insert into employeesName( id , Name ) values ( NEWID() , 'Laurice Pacht');
insert into employeesName( id , Name ) values ( NEWID() , 'Tally Eliesco');
insert into employeesName( id , Name ) values ( NEWID() , 'Livvyy Biernat');
insert into employeesName( id , Name ) values ( NEWID() , 'Doy Milesap');
insert into employeesName( id , Name ) values ( NEWID() , 'Jodi Juan');
insert into employeesName( id , Name ) values ( NEWID() , 'Hastings Farrand');
insert into employeesName( id , Name ) values ( NEWID() , 'Ulla Whight');
insert into employeesName( id , Name ) values ( NEWID() , 'Kamilah Paolotto');
insert into employeesName( id , Name ) values ( NEWID() , 'Matthus Allington');
insert into employeesName( id , Name ) values ( NEWID() , 'Herc Reynard');
insert into employeesName( id , Name ) values ( NEWID() , 'Mychal O''Day');
insert into employeesName( id , Name ) values ( NEWID() , 'Robinetta Ofield');
insert into employeesName( id , Name ) values ( NEWID() , 'Melloney Kay');
insert into employeesName( id , Name ) values ( NEWID() , 'Fred Betke');
insert into employeesName( id , Name ) values ( NEWID() , 'Blondie Jeggo');
insert into employeesName( id , Name ) values ( NEWID() , 'Penrod Flippen');
insert into employeesName( id , Name ) values ( NEWID() , 'Kassandra Fines');
insert into employeesName( id , Name ) values ( NEWID() , 'Cherye Larkkem');
insert into employeesName( id , Name ) values ( NEWID() , 'Lorianna Doige');
insert into employeesName( id , Name ) values ( NEWID() , 'Fowler Vispo');
insert into employeesName( id , Name ) values ( NEWID() , 'Sileas Getcliffe');
insert into employeesName( id , Name ) values ( NEWID() , 'Cate Craighead');
insert into employeesName( id , Name ) values ( NEWID() , 'Hugo Cattellion');
insert into employeesName( id , Name ) values ( NEWID() , 'Toiboid McNaughton');
insert into employeesName( id , Name ) values ( NEWID() , 'Ralph Lagden');
insert into employeesName( id , Name ) values ( NEWID() , 'Meggi Briat');
insert into employeesName( id , Name ) values ( NEWID() , 'Janith Ferenczi');
insert into employeesName( id , Name ) values ( NEWID() , 'Farly Phil');
insert into employeesName( id , Name ) values ( NEWID() , 'Olav Skures');
insert into employeesName( id , Name ) values ( NEWID() , 'Izzy Whitby');
insert into employeesName( id , Name ) values ( NEWID() , 'Chet Radbourn');
insert into employeesName( id , Name ) values ( NEWID() , 'Eden Fox');
insert into employeesName( id , Name ) values ( NEWID() , 'Olivero Lawty');
insert into employeesName( id , Name ) values ( NEWID() , 'Jenni MacCartney');
insert into employeesName( id , Name ) values ( NEWID() , 'Tuck Lonsdale');
insert into employeesName( id , Name ) values ( NEWID() , 'Lolita Benoey');
insert into employeesName( id , Name ) values ( NEWID() , 'Neill Percival');
insert into employeesName( id , Name ) values ( NEWID() , 'Dalia Purshouse');
insert into employeesName( id , Name ) values ( NEWID() , 'Olivier Perrigo');
insert into employeesName( id , Name ) values ( NEWID() , 'Traver Gabbitus');
insert into employeesName( id , Name ) values ( NEWID() , 'Jojo Dallow');
insert into employeesName( id , Name ) values ( NEWID() , 'Francyne Rauprich');
insert into employeesName( id , Name ) values ( NEWID() , 'Derk Darree');
insert into employeesName( id , Name ) values ( NEWID() , 'Beatrice Lanceley');
insert into employeesName( id , Name ) values ( NEWID() , 'Nancy Pinfold');
insert into employeesName( id , Name ) values ( NEWID() , 'Trescha Samet');
insert into employeesName( id , Name ) values ( NEWID() , 'Wiley Stut');
insert into employeesName( id , Name ) values ( NEWID() , 'Gasparo D''Antuoni');
insert into employeesName( id , Name ) values ( NEWID() , 'Kordula Dullard');
insert into employeesName( id , Name ) values ( NEWID() , 'Shalna Loughman');
insert into employeesName( id , Name ) values ( NEWID() , 'Launce Corrado');
insert into employeesName( id , Name ) values ( NEWID() , 'Kennie Gockeler');
insert into employeesName( id , Name ) values ( NEWID() , 'Harmonie Strugnell');
insert into employeesName( id , Name ) values ( NEWID() , 'Melly Walles');
insert into employeesName( id , Name ) values ( NEWID() , 'Donnamarie Spiteri');
insert into employeesName( id , Name ) values ( NEWID() , 'Prescott Fratczak');
insert into employeesName( id , Name ) values ( NEWID() , 'Briney Irvin');
insert into employeesName( id , Name ) values ( NEWID() , 'Ainslie Robelow');
insert into employeesName( id , Name ) values ( NEWID() , 'Oralla Gobeaux');
insert into employeesName( id , Name ) values ( NEWID() , 'Sig De Roos');
insert into employeesName( id , Name ) values ( NEWID() , 'Keven Featherston');
insert into employeesName( id , Name ) values ( NEWID() , 'Douglas Margetts');
insert into employeesName( id , Name ) values ( NEWID() , 'Hali Douglas');
insert into employeesName( id , Name ) values ( NEWID() , 'Nathaniel Ciciura');
insert into employeesName( id , Name ) values ( NEWID() , 'Eada Wimes');
insert into employeesName( id , Name ) values ( NEWID() , 'Allina Austick');
insert into employeesName( id , Name ) values ( NEWID() , 'Eugenie McGiffie');
insert into employeesName( id , Name ) values ( NEWID() , 'Stevana Gatley');
insert into employeesName( id , Name ) values ( NEWID() , 'Cyndy Boutellier');
insert into employeesName( id , Name ) values ( NEWID() , 'Petronille Croal');
insert into employeesName( id , Name ) values ( NEWID() , 'Madel Dymond');
insert into employeesName( id , Name ) values ( NEWID() , 'Obediah Flanne');
insert into employeesName( id , Name ) values ( NEWID() , 'Ailyn Longfellow');
insert into employeesName( id , Name ) values ( NEWID() , 'Ronnie Fretson');
insert into employeesName( id , Name ) values ( NEWID() , 'Georgeta Lemarie');
insert into employeesName( id , Name ) values ( NEWID() , 'Kay Cartmel');
insert into employeesName( id , Name ) values ( NEWID() , 'Jori Newlyn');
insert into employeesName( id , Name ) values ( NEWID() , 'Leif Gumb');
insert into employeesName( id , Name ) values ( NEWID() , 'Inglebert Pert');
insert into employeesName( id , Name ) values ( NEWID() , 'Judas Haville');
insert into employeesName( id , Name ) values ( NEWID() , 'Kelly Shellum');
insert into employeesName( id , Name ) values ( NEWID() , 'Rad Sansam');
insert into employeesName( id , Name ) values ( NEWID() , 'Richardo Hamlyn');
insert into employeesName( id , Name ) values ( NEWID() , 'Annmarie Vasilkov');
insert into employeesName( id , Name ) values ( NEWID() , 'Rey De Carteret');
insert into employeesName( id , Name ) values ( NEWID() , 'Mariam Eykel');
insert into employeesName( id , Name ) values ( NEWID() , 'Ramonda Baggallay');
insert into employeesName( id , Name ) values ( NEWID() , 'Teressa Rissom');
insert into employeesName( id , Name ) values ( NEWID() , 'Ennis Iannitti');
insert into employeesName( id , Name ) values ( NEWID() , 'Karleen Willoughway');
insert into employeesName( id , Name ) values ( NEWID() , 'Anselm Carncross');
insert into employeesName( id , Name ) values ( NEWID() , 'Abey Crame');
insert into employeesName( id , Name ) values ( NEWID() , 'Faydra Timoney');
insert into employeesName( id , Name ) values ( NEWID() , 'Gabie Molyneaux');
insert into employeesName( id , Name ) values ( NEWID() , 'Ulrika Braden');
insert into employeesName( id , Name ) values ( NEWID() , 'Gui Holleran');
insert into employeesName( id , Name ) values ( NEWID() , 'Reginauld Measor');
insert into employeesName( id , Name ) values ( NEWID() , 'Johnathan Sandyford');
insert into employeesName( id , Name ) values ( NEWID() , 'Ernesto Broxup');
insert into employeesName( id , Name ) values ( NEWID() , 'Meg Sinyard');
insert into employeesName( id , Name ) values ( NEWID() , 'Papageno Glison');
insert into employeesName( id , Name ) values ( NEWID() , 'Miguela Berrey');
insert into employeesName( id , Name ) values ( NEWID() , 'Annie Nuzzti');
insert into employeesName( id , Name ) values ( NEWID() , 'Wallie Sopp');
insert into employeesName( id , Name ) values ( NEWID() , 'Jemima Belloch');
insert into employeesName( id , Name ) values ( NEWID() , 'Kathleen Rembaud');
insert into employeesName( id , Name ) values ( NEWID() , 'Husain Haldon');
insert into employeesName( id , Name ) values ( NEWID() , 'Tyrus Bednell');
insert into employeesName( id , Name ) values ( NEWID() , 'Laverne Steenson');
insert into employeesName( id , Name ) values ( NEWID() , 'Jo-ann Paulet');
insert into employeesName( id , Name ) values ( NEWID() , 'Reggie Agg');
insert into employeesName( id , Name ) values ( NEWID() , 'Gran McNiff');
insert into employeesName( id , Name ) values ( NEWID() , 'Ludovika Bispham');
insert into employeesName( id , Name ) values ( NEWID() , 'Inga Hensmans');
insert into employeesName( id , Name ) values ( NEWID() , 'Kristofor Moorwood');
insert into employeesName( id , Name ) values ( NEWID() , 'Lilyan Dyett');
insert into employeesName( id , Name ) values ( NEWID() , 'Rivy Harpur');
insert into employeesName( id , Name ) values ( NEWID() , 'Elly Eliot');
insert into employeesName( id , Name ) values ( NEWID() , 'Laina Pinnick');
insert into employeesName( id , Name ) values ( NEWID() , 'Swen Davisson');
insert into employeesName( id , Name ) values ( NEWID() , 'Foster Lynnitt');
insert into employeesName( id , Name ) values ( NEWID() , 'Milissent Franceschino');
insert into employeesName( id , Name ) values ( NEWID() , 'Eben Regler');
insert into employeesName( id , Name ) values ( NEWID() , 'Genevra Ponton');
insert into employeesName( id , Name ) values ( NEWID() , 'Charley Mathet');
insert into employeesName( id , Name ) values ( NEWID() , 'Tito Andor');
insert into employeesName( id , Name ) values ( NEWID() , 'Angie Piken');
insert into employeesName( id , Name ) values ( NEWID() , 'Mack Bloodworthe');
insert into employeesName( id , Name ) values ( NEWID() , 'Jaymie Fairlamb');
insert into employeesName( id , Name ) values ( NEWID() , 'Alexis Almey');
insert into employeesName( id , Name ) values ( NEWID() , 'Tedda Skalls');
insert into employeesName( id , Name ) values ( NEWID() , 'Ambur Gyrgorwicx');
insert into employeesName( id , Name ) values ( NEWID() , 'Madonna MacDougal');
insert into employeesName( id , Name ) values ( NEWID() , 'Mureil Vynall');
insert into employeesName( id , Name ) values ( NEWID() , 'Edmund Udie');
insert into employeesName( id , Name ) values ( NEWID() , 'Chlo Mantram');
insert into employeesName( id , Name ) values ( NEWID() , 'Clim Goldspink');
insert into employeesName( id , Name ) values ( NEWID() , 'Jerrilee Ainslee');
insert into employeesName( id , Name ) values ( NEWID() , 'Ginger Rowell');
insert into employeesName( id , Name ) values ( NEWID() , 'Marlyn Ackrill');
insert into employeesName( id , Name ) values ( NEWID() , 'Vilma Gawler');
insert into employeesName( id , Name ) values ( NEWID() , 'Oralee Pimm');
insert into employeesName( id , Name ) values ( NEWID() , 'Sharl Schreurs');
insert into employeesName( id , Name ) values ( NEWID() , 'Madalyn Hawes');
insert into employeesName( id , Name ) values ( NEWID() , 'Jinny Eskriet');
insert into employeesName( id , Name ) values ( NEWID() , 'Jeremie MacMoyer');
insert into employeesName( id , Name ) values ( NEWID() , 'Clementine Columbine');
insert into employeesName( id , Name ) values ( NEWID() , 'Andromache Lyttle');
insert into employeesName( id , Name ) values ( NEWID() , 'Jocko Callum');
insert into employeesName( id , Name ) values ( NEWID() , 'Asia Gristhwaite');
insert into employeesName( id , Name ) values ( NEWID() , 'Marlo Fenimore');
insert into employeesName( id , Name ) values ( NEWID() , 'Harriett Penniell');
insert into employeesName( id , Name ) values ( NEWID() , 'Ric Segot');
insert into employeesName( id , Name ) values ( NEWID() , 'Romy Oldmeadow');
insert into employeesName( id , Name ) values ( NEWID() , 'Bailey McDarmid');
insert into employeesName( id , Name ) values ( NEWID() , 'Baxie Nicklin');
insert into employeesName( id , Name ) values ( NEWID() , 'Christan Alexsandrovich');
insert into employeesName( id , Name ) values ( NEWID() , 'Creigh Beagin');
insert into employeesName( id , Name ) values ( NEWID() , 'Hieronymus Riccard');
insert into employeesName( id , Name ) values ( NEWID() , 'Helena Royste');
insert into employeesName( id , Name ) values ( NEWID() , 'Allison Stading');
insert into employeesName( id , Name ) values ( NEWID() , 'Vale Attreed');
insert into employeesName( id , Name ) values ( NEWID() , 'Anthia Urrey');
insert into employeesName( id , Name ) values ( NEWID() , 'Wendy Firebrace');
insert into employeesName( id , Name ) values ( NEWID() , 'Neill Quartermain');
insert into employeesName( id , Name ) values ( NEWID() , 'Lev Karczinski');
insert into employeesName( id , Name ) values ( NEWID() , 'Pryce Bartalucci');
insert into employeesName( id , Name ) values ( NEWID() , 'Staffard Bogie');
insert into employeesName( id , Name ) values ( NEWID() , 'Franklin Carlon');
insert into employeesName( id , Name ) values ( NEWID() , 'Laurianne Barenskie');
insert into employeesName( id , Name ) values ( NEWID() , 'Audrie Pelerin');
insert into employeesName( id , Name ) values ( NEWID() , 'Nicoline Corzon');
insert into employeesName( id , Name ) values ( NEWID() , 'Gert Harmstone');
insert into employeesName( id , Name ) values ( NEWID() , 'Darbee Oblein');
insert into employeesName( id , Name ) values ( NEWID() , 'Doria Cianni');
insert into employeesName( id , Name ) values ( NEWID() , 'Raffaello Durston');
insert into employeesName( id , Name ) values ( NEWID() , 'Simone Brotherhood');
insert into employeesName( id , Name ) values ( NEWID() , 'Kellen Johanning');
insert into employeesName( id , Name ) values ( NEWID() , 'Jourdan Nail');
insert into employeesName( id , Name ) values ( NEWID() , 'Far Withur');
insert into employeesName( id , Name ) values ( NEWID() , 'Emelen Linn');
insert into employeesName( id , Name ) values ( NEWID() , 'Rani Iowarch');
insert into employeesName( id , Name ) values ( NEWID() , 'Doria Bigadike');
insert into employeesName( id , Name ) values ( NEWID() , 'Gilburt Dugald');
insert into employeesName( id , Name ) values ( NEWID() , 'Florida Jansen');
insert into employeesName( id , Name ) values ( NEWID() , 'Ellette Trays');
insert into employeesName( id , Name ) values ( NEWID() , 'Margit Storek');
insert into employeesName( id , Name ) values ( NEWID() , 'Alecia Meeron');
insert into employeesName( id , Name ) values ( NEWID() , 'Gilligan Kenvin');
insert into employeesName( id , Name ) values ( NEWID() , 'Lelah Oakenfield');
insert into employeesName( id , Name ) values ( NEWID() , 'Celie Waddicor');
insert into employeesName( id , Name ) values ( NEWID() , 'Ardelia Stanley');
insert into employeesName( id , Name ) values ( NEWID() , 'Stacy Pocknoll');
insert into employeesName( id , Name ) values ( NEWID() , 'Angelica O''Neil');
insert into employeesName( id , Name ) values ( NEWID() , 'Webb Saich');
insert into employeesName( id , Name ) values ( NEWID() , 'Micah Bonnor');
insert into employeesName( id , Name ) values ( NEWID() , 'Olav Crimp');
insert into employeesName( id , Name ) values ( NEWID() , 'Hymie Tomashov');
insert into employeesName( id , Name ) values ( NEWID() , 'Klaus Cordle');
insert into employeesName( id , Name ) values ( NEWID() , 'Cairistiona Prudence');
insert into employeesName( id , Name ) values ( NEWID() , 'Saunder Beecraft');
insert into employeesName( id , Name ) values ( NEWID() , 'Agustin Rickeard');
insert into employeesName( id , Name ) values ( NEWID() , 'Darren Bachs');
insert into employeesName( id , Name ) values ( NEWID() , 'Wendel Bawdon');
insert into employeesName( id , Name ) values ( NEWID() , 'Lacie Kennedy');
insert into employeesName( id , Name ) values ( NEWID() , 'Dru Pollitt');
insert into employeesName( id , Name ) values ( NEWID() , 'Saxon Purtell');
insert into employeesName( id , Name ) values ( NEWID() , 'Hollis Frunks');
insert into employeesName( id , Name ) values ( NEWID() , 'Vic Jerschke');
insert into employeesName( id , Name ) values ( NEWID() , 'Tabbatha Birch');
insert into employeesName( id , Name ) values ( NEWID() , 'Elga Eschalotte');
insert into employeesName( id , Name ) values ( NEWID() , 'Lona Byer');
insert into employeesName( id , Name ) values ( NEWID() , 'Geri Palumbo');
insert into employeesName( id , Name ) values ( NEWID() , 'Eleni Stanbrooke');
insert into employeesName( id , Name ) values ( NEWID() , 'Augustin Fairhead');
insert into employeesName( id , Name ) values ( NEWID() , 'Berkie McIlveen');

go




    DECLARE @BranchId UNIQUEIDENTIFIER;
    DECLARE @DepartmentId UNIQUEIDENTIFIER;
    DECLARE @EmployeeName NVARCHAR(50);  -- Tên đầy đủ của nhân viên
    DECLARE @Salary INT;
    DECLARE @Dob DATE;
    DECLARE @StartDate DATE;
    DECLARE @DepartmentCount INT;
    DECLARE @DepartmentIndex INT;

    -- Get the number of departments (giả sử có 7 phòng ban trong hệ thống)
    SELECT @DepartmentCount = COUNT(*) FROM Departments;
    
    -- Ensure there are exactly 7 departments
    IF @DepartmentCount <> 7
    BEGIN
        RAISERROR('There must be exactly 7 departments', 16, 1);
        RETURN;
    END

    -- Loop through each Branch
    DECLARE BranchCursor CURSOR FOR SELECT BranchId FROM Branches;
    OPEN BranchCursor;

    FETCH NEXT FROM BranchCursor INTO @BranchId;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @DepartmentIndex = 0;  -- Start with the first department for each branch

        -- Insert 50 employees for the current branch, evenly distributing across departments
        DECLARE @EmployeeCounter INT = 1;
        WHILE @EmployeeCounter <= 50
        BEGIN
            -- Select Department in a round-robin fashion
            SELECT @DepartmentId = DepartmentId 
            FROM (SELECT DepartmentId, ROW_NUMBER() OVER (ORDER BY DepartmentId) AS RowNum 
                  FROM Departments) AS Dept
            WHERE Dept.RowNum = ((@DepartmentIndex % @DepartmentCount) + 1);

            -- Get the BaseSalary for the selected department
            SELECT @Salary = BaseSalary FROM Departments WHERE DepartmentId = @DepartmentId;

            -- Select a random employee name from the employeesName table
            SELECT TOP 1 @EmployeeName = name
            FROM employeesName
            ORDER BY NEWID();  -- Randomly select a name

            -- Generate random DOB and StartDate for the new employee
            SET @Dob = DATEADD(YEAR, -20 - (ABS(CHECKSUM(NEWID())) % 20), GETDATE()); -- Random DOB between 20 and 40 years ago
            SET @StartDate = DATEADD(YEAR, -ABS(CHECKSUM(NEWID()) % 5), GETDATE()); -- Random start date within last 5 years

            -- Insert the employee with the same salary for the same department
            INSERT INTO Employees (Id, Name, Dob, Gender, Salary, StartDate, DepartmentId, BranchId)
            VALUES (NEWID(), @EmployeeName, @Dob, N'Nam', @Salary, @StartDate, @DepartmentId, @BranchId);

            -- Move to the next department in round-robin
            SET @DepartmentIndex = @DepartmentIndex + 1;
            SET @EmployeeCounter = @EmployeeCounter + 1;
        END

        FETCH NEXT FROM BranchCursor INTO @BranchId;
    END

    CLOSE BranchCursor;
    DEALLOCATE BranchCursor;






go

--customer 
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Julissa Esh', '2/18/2024', 2, '2383341366', '151-371-5492', 'jesh0@buzzfeed.com', '42552a82-6496-4cab-ab61-6a125f75152d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dore Skune', '5/22/2024', 1, '0932361546', '356-645-7866', 'dskune1@netscape.com', '36378328-2db0-4c98-b44a-f7542021045f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tades Orchart', '6/6/2024', 3, '7575127787', '804-879-2618', 'torchart2@ycombinator.com', '1883ac47-0372-4d38-9f41-146aadc06602');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aidan Earney', '5/2/2024', 2, '3608675227', '507-757-0012', 'aearney3@indiegogo.com', '2ddc4685-7966-45ec-97ea-80d9abb17ea0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Esther Dymond', '10/22/2024', 1, '5070328466', '791-260-7804', 'edymond4@upenn.edu', '43295e16-c13f-474b-86e5-5a005632bbcb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rickie Baish', '4/11/2024', 2, '4280777475', '227-745-1349', 'rbaish5@berkeley.edu', '9ced2778-6f2c-4648-b162-1bebf4d0b14f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Skell Goldsack', '8/14/2024', 1, '9274069791', '255-651-1790', 'sgoldsack6@hatena.ne.jp', '0b0790b1-7c26-4295-8e25-2fb6f4bf2466');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gill Peskett', '1/24/2024', 2, '0731026297', '251-818-6794', 'gpeskett7@tamu.edu', '6da4f797-be67-47a2-b770-1c89020a74c6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Marcia Baldcock', '1/9/2024', 1, '2462880113', '319-175-9801', 'mbaldcock8@stanford.edu', 'fbe4918f-bf8f-424d-8ebf-eba38f7db890');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Isobel Grinin', '7/12/2024', 2, '8100921290', '765-357-2111', 'igrinin9@cocolog-nifty.com', 'cde22b3e-f727-43d1-bd4d-42bd5e2fe452');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Slade Doman', '7/7/2024', 2, '9507836059', '957-597-4436', 'sdomana@umich.edu', '293fafec-9c34-4149-8a62-6fa4c6437dfb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Luce Jugging', '11/26/2023', 2, '7241780754', '344-721-1966', 'ljuggingb@about.me', '778011e0-9a20-446f-908a-15c1612025b8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Averell Mulloch', '1/4/2024', 2, '6937094481', '812-507-2477', 'amullochc@springer.com', '9b22c13e-924f-43c0-8599-3241f8ff3a84');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Pail_check_check Drivers', '2/17/2024', 3, '9953783251', '964-275-0412', 'pdriversd@boston.com', 'cbee8615-a543-4079-99f4-8dc19fbb5daa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chas Lowings', '6/27/2024', 1, '2844041585', '322-155-8438', 'clowingse@hatena.ne.jp', '5c8daac6-ec0a-44c5-a3ff-0f4d6c767b3d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Johny_check Demare', '1/14/2024', 3, '0172818456', '634-182-1111', 'jdemaref@dot.gov', 'b82e184c-3d9f-4dd3-8df0-c5eee04694fb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Naomi Powe', '2/21/2024', 1, '3883122811', '522-474-7016', 'npoweg@domainmarket.com', '8b7b8993-25da-4f7f-9bdc-ff4ce6ddad14');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Devland Kennefick', '12/14/2023', 3, '4884376173', '287-195-1511', 'dkennefickh@jalbum.net', 'b9e99f0f-c6cc-4724-aea5-0a71bfa905c2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Will Houlaghan', '12/24/2023', 2, '2077392603', '301-960-0439', 'whoulaghani@walmart.com', '9793d510-2db6-437f-8f3b-587f98e57f66');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hunt Grisewood', '9/21/2024', 1, '9584578063', '445-965-0589', 'hgrisewoodj@reverbnation.com', 'fbb61db1-8dda-4a2d-9910-82dd8305a2d8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Donnie Chipps', '3/19/2024', 1, '4859127179', '840-669-3940', 'dchippsk@sakura.ne.jp', '54987364-39e6-42dc-afd6-7592955647f1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aron Volker', '7/24/2024', 3, '2931813681', '339-140-8550', 'avolkerl@meetup.com', '48c0e2ae-006e-4ce7-8039-13f81a228361');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lukas Stapells', '8/9/2024', 1, '8209538662', '830-628-9002', 'lstapellsm@prnewswire.com', 'ecaad9bb-9287-4615-9c6c-78bd910b5693');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Celestia Golledge', '2/21/2024', 1, '4168327607', '754-346-6305', 'cgolledgen@simplemachines.org', '26142138-798b-4f0f-883d-3e6c6663cadd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dukey Rawet', '7/4/2024', 2, '4253175516', '833-648-6618', 'draweto@home.pl', '2a1fde5e-7f73-408e-9c6d-a61436d7f035');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dara Carrol', '6/21/2024', 3, '6522700097', '452-978-8923', 'dcarrolp@networkadvertising.org', 'aeceb7cc-64d2-4bdd-812a-7c34bf5294bf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fayre Ojeda', '1/6/2024', 1, '9603312029', '292-713-1379', 'fojedaq@canalblog.com', '89a3128c-8032-4dc5-80fc-6cabe1afaa00');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Conrad_check Colthard', '2/22/2024', 3, '3131306263', '962-965-3138', 'ccolthardr@icio.us', '6bdad666-1e9c-4a39-ab58-87e859d3bff7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chaim Ritmeier', '5/29/2024', 1, '2170801738', '983-761-8832', 'critmeiers@usnews.com', '0b74d40a-2232-4eed-84b1-738e5dc4bba6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Osborn Grimsdyke', '3/21/2024', 3, '6875206353', '768-381-3025', 'ogrimsdyket@phoca.cz', '457dd415-8367-46ea-ab1e-f5b36eb0dfbb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ricard_check Silversmidt', '10/18/2024', 1, '5123472830', '560-420-6810', 'rsilversmidtu@utexas.edu', '51a8f7ad-1f92-4c93-bcff-f8f0bc503b4a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Estevan How to preserve', '3/2/2024', 3, '8571552201', '151-302-9079', 'ehowv@bing.com', '530b95c7-2970-4b3b-8ab5-cb11e3a640c3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Doll Erat', '1/4/2024', 2, '2673775281', '148-711-6409', 'deratw@pcworld.com', '8031d95c-8276-499f-b839-56a36bffae34');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Annabella Roan', '1/7/2024', 2, '7719782004', '954-117-3076', 'aroanx@webeden.co.uk', '176c1659-c4f1-414f-b9f1-2762bfc97a0e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Melany_check McBrearty', '7/24/2024', 1, '1678225381', '285-491-1421', 'mmcbreartyy@sciencedirect.com', '5c0aeebb-25d8-4ee8-ab84-2e4a3ff229f5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sarene Goldston', '4/13/2024', 3, '5780179908', '420-273-1044', 'sgoldstonz@mapquest.com', 'c2ba0492-32a6-4f4a-8642-55bb9f42427a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Humphrey Tate', '6/28/2024', 1, '7765546671', '454-732-8036', 'htate10@photobucket.com', '459b424f-eb4a-4997-a941-dc9e49ab1d2a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Park_check Brewse', '8/7/2024', 1, '0788322525', '516-492-0076', 'pbrewse11@washingtonpost.com', 'c81dd271-06bf-4ff6-91d9-2f1e2bdf1d25');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Reina Jales', '6/20/2024', 2, '9275160000', '338-911-3741', 'rjales12@skyrock.com', '051cbe38-5d1a-41ae-8476-ab35731a8e9a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carena Broxholme', '8/9/2024', 3, '5099513785', '357-579-5654', 'cbroxholme13@columbia.edu', '7515debe-db2c-4c2d-b1af-1849c5af322f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Robbi Proswell', '10/7/2024', 2, '1269227485', '830-439-3916', 'rproswell14@bravesites.com', '7eed4c93-22ab-4f87-b486-ee29652845fd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Anette_check Casa', '7/18/2024', 3, '1944859068', '996-745-9933', 'acasa15@dropbox.com', '1ded3b11-2337-4f73-9c62-69402cecf3c3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nerty McVeagh', '4/21/2024', 2, '0316586966', '773-512-0304', 'nmcveagh16@prlog.org', 'd49966db-891e-443f-a926-9327797dd26e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sibelle Copeland', '12/19/2023', 3, '6416507049', '476-667-9617', 'scopeland17@privacy.gov.au', '5ea460c6-4914-4efd-9ea8-0458b15f4ddc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosamond Fakeley', '5/18/2024', 2, '9529945193', '910-317-6999', 'rfakeley18@techcrunch.com', '2cf4d4d6-997b-4bc9-b7a1-ebf401994c15');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dill Pietesch', '12/3/2023', 2, '6214661445', '786-884-1633', 'dpietesch19@4shared.com', '26a4e504-0b9d-4490-86e4-f594d97c68ad');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Scarface Kaes', '5/11/2024', 2, '3668068189', '848-736-8597', 'skaes1a@rediff.com', '67ac2c80-af4a-4db6-bf51-5c8977d26c32');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kara-lynn Walklot', '2/24/2024', 2, '4831152505', '995-787-0766', 'kwalklot1b@cmu.edu', '56a5a66a-51b9-4264-8dfe-0f57d9438ae7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ninetta Buswell', '4/9/2024', 1, '6978150343', '294-827-3523', 'nbuswell1c@flavors.me', '2ed1fc60-f4fc-42ff-9130-d7aa7a095e65');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cristin_check Bartlosz', '12/20/2023', 2, '8310078655', '392-277-2291', 'cbartlosz1d@bluehost.com', 'f750d2d0-e156-421b-be7a-e116dabfa8d6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Felice Martill', '11/18/2023', 3, '2270897662', '130-687-2446', 'fmartill1e@kickstarter.com', 'c09f12c0-9ba7-4c5d-84f3-bc40886c2b4f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brien Slograve', '11/12/2024', 3, '5851228231', '533-310-4081', 'bslograve1f@vk.com', '7344fc8f-a3c3-477b-9817-acbbf6143caa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brooks Curm', '7/27/2024', 3, '1951103388', '387-972-1407', 'bcurm1g@com.com', '30d0db1d-fcdc-4214-8358-4bccff4a9c82');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shea Mattinson', '1/22/2024', 2, '5911741231', '914-387-6954', 'smattinson1h@360.cn', '2576264d-c15d-4b5e-9ee1-b179c8cb1c64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Boonie Tolson', '12/16/2023', 2, '7411961795', '164-968-9820', 'btolson1i@networksolutions.com', 'a5a51290-2668-4a04-8218-4973b3475e78');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Evelyn Castellan', '5/15/2024', 2, '2809783625', '429-284-2454', 'ecastellan1j@amazonaws.com', '6b7190db-33fc-4325-8ce9-c99fb8b8e301');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dalston Mickan', '8/10/2024', 3, '6523893581', '112-175-2100', 'dmickan1k@cloudflare.com', '4a79b56c-b92a-4336-a8cf-f63840b08232');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andrei Feathersby', '6/18/2024', 3, '8713289945', '695-335-1523', 'afeathersby1l@ebay.com', 'bc453813-a4fc-4c5e-b52b-2c151defdc60');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shawna Mea', '2/16/2024', 1, '5862896028', '388-958-0919', 'smea1m@amazon.co.jp', 'ba9836b5-d6ca-4f73-a170-9b22fbce1856');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kyle Bourgourd', '4/26/2024', 1, '4738414071', '231-852-1694', 'kbourgourd1n@sciencedirect.com', '32606479-12fe-4926-9579-6384bd18f141');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stevena Mibourne', '2/18/2024', 1, '9005947764', '726-876-1989', 'smibourne1o@themeforest.net', '8dd54c56-c2a2-4728-88b1-a02936c179a0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Randal Osbidston', '8/20/2024', 2, '6078731190', '292-566-0025', 'rosbidston1p@google.ca', 'e08846f1-3ee0-4520-b67d-23508699f1f0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leola Tomei', '4/7/2024', 1, '7332335047', '558-340-8549', 'ltomei1q@naver.com', '23d11223-b6bf-4e0a-9fd7-e6caab957ac4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kathy Nottram', '3/16/2024', 1, '6572295954', '982-932-0476', 'knottram1r@dot.gov', '1e8205ff-a517-4210-92ab-65535496f339');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Inglis Dulling', '7/18/2024', 2, '8856305015', '765-841-6834', 'idulling1s@rediff.com', '8b42193a-07d9-499b-aa4e-b5bd0dd7b381');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lita Mazey', '11/17/2023', 1, '2119659733', '334-384-2050', 'lmazey1t@dell.com', '5d498679-466a-4996-a5ec-21425f0e8a40');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ignace Moohan', '7/29/2024', 3, '3777133251', '555-544-0260', 'imoohan1u@newyorker.com', '15774939-f10e-4d13-a6a4-573ac42a4057');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ebba Middis', '5/22/2024', 3, '9172996803', '483-682-6646', 'emiddis1v@nih.gov', 'c92c78b6-8979-46c0-bc69-00da78108a32');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Benton Cannell', '9/4/2024', 3, '3070858558', '963-100-6868', 'bcannell1w@jiathis.com', 'f1f09029-5795-4b57-b613-27e8b57f6cd7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cathe Wordsley', '3/18/2024', 3, '2002644877', '384-825-8429', 'cwordsley1x@google.de', '3b59a7e9-3f26-478d-ac58-be4007520d45');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Joelynn Mish', '7/1/2024', 1, '5446156193', '775-641-7503', 'jmish1y@army.mil', '3d375b72-d727-42c5-8d14-1686fb8ac219');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sadie Grafton', '11/6/2024', 1, '9274535665', '694-471-5649', 'sgrafton1z@google.cn', '84ab460c-36cb-4916-b677-d73b64fdc585');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Isidor Fuchs', '1/6/2024', 1, '7580187112', '755-334-3234', 'ifuchs20@symantec.com', 'd9f73f6c-1624-457a-aa52-b549125a56eb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Izaak Olenichev', '1/21/2024', 3, '6370207683', '517-329-7033', 'iolenichev21@bloglines.com', 'e8068630-2fe7-483a-83e8-c25af04505dc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bliss Reddie', '5/25/2024', 3, '4286773862', '461-245-1016', 'breddie22@nydailynews.com', '03fcf135-faf9-494a-9454-9311e9ce505d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sabine Westwick', '2/5/2024', 2, '6696231382', '127-333-4980', 'swestwick23@ustream.tv', 'd97f766e-8695-4b7e-b490-99bd63735619');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Johna Petrovsky', '5/23/2024', 3, '3388796105', '933-925-6357', 'jpetrovsky24@accuweather.com', '17c5b9e8-1d98-44ba-bc29-e675b976a6e8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dolli Cawthry', '2/17/2024', 1, '1404230514', '801-888-2613', 'dcawthry25@dropbox.com', 'd23d9cef-3971-4dfe-9292-1b20bb428f32');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Currey Cockerell', '10/19/2024', 2, '4437773270', '697-228-9464', 'ccockerell26@reference.com', '52e16ff1-0b4e-4fcd-8e96-2d2c384ea35d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Joy Kebbell', '7/12/2024', 1, '4606035124', '739-256-8117', 'jkebbell27@columbia.edu', '425cb938-1522-4b18-a633-8a0c519d6693');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thane Ottee', '11/30/2023', 3, '2590166148', '721-479-6354', 'tottee28@wordpress.com', 'deb6de33-2d29-4b80-bb44-37214796194f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sorcha Folder', '1/13/2024', 2, '8385960766', '665-487-1937', 'sfolder29@walmart.com', '6b94e3f3-cce5-476f-9b9c-ee577f0e53d2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alissa_check Praill', '3/7/2024', 1, '8205307920', '865-584-4327', 'apraill2a@mapquest.com', '33cab5ce-dbf6-4007-850d-4f9cf76eb6c7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elihu Petre', '3/4/2024', 1, '4384630789', '501-511-6436', 'epetre2b@amazon.co.jp', 'bb537a00-b506-47cb-8f28-19900404ac44');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Blake Margery', '9/20/2024', 2, '6396173802', '468-189-0164', 'bmargery2c@example.com', '3c080c90-988f-4468-9164-b63fe85bbd07');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nerty Roussel', '4/23/2024', 3, '4617120473', '263-193-4999', 'nroussel2d@bluehost.com', '222c1d19-0908-4fe7-a22f-f5dcd2667c4c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aprilette_check Surman', '7/21/2024', 2, '3152410730', '873-792-0148', 'asurman2e@bandcamp.com', '0ede7d71-f12e-4dc0-9fe8-792518924795');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Verla Marran', '9/17/2024', 3, '6480890756', '678-780-8304', 'vmarran2f@thetimes.co.uk', 'b76e851e-6d23-4836-8e6a-08bafede4797');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alli Gosnoll', '11/26/2023', 2, '5172843186', '899-165-3004', 'agosnoll2g@wordpress.com', 'd7525991-1cb8-4228-bc7c-80ac032eede7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Karalynn Costigan', '6/14/2024', 2, '6133908110', '334-173-5849', 'kcostigan2h@apple.com', 'c14eb24b-7004-4d42-9706-7c582abfa652');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Craggie_check Eisikowitch', '11/20/2023', 2, '4063874160', '598-244-8959', 'ceisikowitch2i@sina.com.cn', '7cd7928e-1898-4f96-a93c-5ea865587187');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sherwynd Galloway', '2/24/2024', 3, '2646404140', '999-158-4568', 'sgalloway2j@harvard.edu', 'e0513749-aaf9-40de-8f21-4deec45649c0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Loren Baddow', '9/4/2024', 1, '5638991195', '889-206-1891', 'lbaddow2k@chron.com', '87d5357e-3a06-4cd0-9e2b-e60d08cbf4b3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Blinny Sinyard', '10/6/2024', 1, '8047830852', '204-300-4348', 'bsinyard2l@msu.edu', 'a8b4d8a5-d952-40ce-af69-4ce0c1730b95');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Susan Lovatt', '7/16/2024', 2, '5028328304', '850-767-6459', 'slovatt2m@usatoday.com', '7b261b17-d9af-494f-8163-a736b2a57c7b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Frederic Mowsdell', '9/8/2024', 1, '6459008924', '276-180-7171', 'fmowsdell2n@aboutads.info', '1ead6fd6-2b02-4f5c-ba0b-828f346f7cc3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Steffane Sieghart', '11/29/2023', 1, '7601936336', '697-586-7926', 'ssieghart2o@nhs.uk', '08245bcd-d324-44fa-a23d-64aa04135ffd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Timotheus Ingleson', '6/9/2024', 1, '4257730889', '839-576-0891', 'tingleson2p@google.de', 'ac7a9413-0203-4e81-b8e2-332fd68c4879');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sophia Ravenscroftt', '4/30/2024', 3, '8544907184', '403-419-6031', 'sravenscroftt2q@yelp.com', '416a4769-48fe-4073-9cbc-606275310fa9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gael Charleston', '6/24/2024', 2, '9037217445', '104-138-7030', 'gcharleston2r@yellowpages.com', 'fe941092-888e-400d-8db3-2f69c310a37f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Denys Hollyar', '11/13/2023', 3, '3164776908', '591-122-1178', 'dhollyar2s@usgs.gov', '60739dea-2bdc-4964-a570-13f79b0a05a7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rozele_check Ocklin', '2/8/2024', 3, '8054215999', '876-973-1388', 'rocklin2t@alibaba.com', '0fdd342f-4cb8-415c-9b09-878f820ad360');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rodrigo Laguerre', '4/17/2024', 3, '9947522253', '723-315-1253', 'rlaguerre2u@shinystat.com', '4fdcec6a-0ac4-4714-b7f4-551cfb523184');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Letta Diss', '3/14/2024', 1, '4600972008', '157-411-3140', 'ldiss2v@buzzfeed.com', '1183f133-f5d4-4553-9c3b-72959083c177');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rancell Arguile', '10/16/2024', 2, '2129183145', '417-235-2648', 'rarguile2w@sitemeter.com', '5976c62b-8c02-4d3f-9b87-aa2b1ae72cd6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gwendolyn Mosedill', '5/17/2024', 1, '6665195614', '106-883-1863', 'gmosedill2x@ox.ac.uk', 'db5e0de3-1318-47f8-ac31-e20ad78250c7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Torrin Zottoli', '12/10/2023', 2, '2646827610', '278-789-7792', 'tzottoli2y@e-recht24.de', '5820ff29-bb92-4d48-a37d-113a1d6895a2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Charlton Stockings', '3/1/2024', 3, '3349939890', '986-613-0762', 'cstockings2z@cdbaby.com', '4c1744cd-59c1-4467-aa00-1a6739c29737');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kellyann Wasiel', '1/16/2024', 2, '0632738388', '736-150-9007', 'kwasiel30@sohu.com', '16164008-3290-4633-a570-4b536a35a74c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Catha_check Marples', '5/22/2024', 1, '7057680207', '439-997-9499', 'cmarples31@cargocollective.com', '68821a9b-e852-4121-b399-2139cf4ba46f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Modesty Beynkn', '4/28/2024', 3, '0756724716', '906-861-4865', 'mbeynkn32@smugmug.com', '869291fb-ff8f-4d9e-b6f0-7e1abe6f8d05');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Abram Kellington', '2/6/2024', 2, '4375535121', '394-269-2817', 'akellington33@alibaba.com', '949fb6b0-7266-4cee-8588-555c1176e76e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Konstance Leisman', '9/18/2024', 2, '5752125400', '980-947-8420', 'kleisman34@tumblr.com', 'f3e11291-14eb-449a-bc23-469855cf4339');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brianna De Benedetti', '3/1/2024', 3, '1315489113', '176-677-3197', 'bde35@smugmug.com', 'bc4e838e-15be-41b5-aebd-1994cb775c91');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wait_check Woolam', '7/10/2024', 3, '8146818459', '142-250-7541', 'wwoolam36@qq.com', 'c6e7ac12-9d9a-4a52-b850-e70de1c1ae3a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elinore Elen', '10/28/2024', 1, '9430387671', '502-103-9008', 'eelen37@taobao.com', 'baac3e21-b63d-4827-b4c4-54aba88d9a2b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Neala_check Horning', '5/30/2024', 1, '9659067994', '260-454-5575', 'nhorning38@kickstarter.com', 'd47c2d95-7b6d-4aaa-b70c-c59b54b6f1f6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arabele Kimpton', '3/21/2024', 3, '9764553546', '379-230-7333', 'akimpton39@oakley.com', '674b3275-a484-4121-ac70-904992c8ec9b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Calla Grindlay', '7/17/2024', 1, '8625092881', '843-703-7093', 'cgrindlay3a@blog.com', 'cd451997-06d9-44b5-81d2-c6ab75b0ad4a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Remus Glavias', '3/2/2024', 3, '5175955838', '931-250-8215', 'rglavias3b@hud.gov', 'c3c8b215-8a43-445c-afbb-514be5ddda65');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salvidor Fozzard', '12/13/2023', 1, '5616447885', '354-858-4979', 'sfozzard3c@barnesandnoble.com', '39fce5fc-4fae-44a1-a9ae-22e7e7a939b7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Anabelle_check Relph', '4/21/2024', 2, '7589230349', '445-348-0329', 'arelph3d@cam.ac.uk', 'dd739344-9d8d-4b73-97d0-2b8c3763adc1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Liesa Blaxeland', '9/20/2024', 1, '8717133229', '960-605-5228', 'lblaxeland3e@nydailynews.com', 'e0e57bbb-72d3-403f-bbba-6b25f14ab7ff');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alie Ivashintsov', '10/21/2024', 3, '1996501781', '821-170-2130', 'aivashintsov3f@xrea.com', '1a2d8be6-7670-49dd-bd74-1d8018e06f31');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nara O''Sheils', '5/17/2024', 3, '0975724904', '826-520-7183', 'nosheils3g@comcast.net', 'ba445b16-ec3a-4b68-bdb4-00be3dbea61f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tristam_check_check Gumary', '6/7/2024', 1, '0695807311', '182-102-8371', 'tgumary3h@t-online.de', 'c66ebbd7-24b5-496b-8a8e-bf685408f817');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rhodia Tomas', '7/2/2024', 3, '7076504834', '864-492-2628', 'rtomas3i@de.vu', '48e72e86-f7f4-4ba8-9bb5-11fa491737ce');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wanda Titterton', '5/8/2024', 2, '4671478011', '164-141-5509', 'wtitterton3j@cbslocal.com', 'f5ceeaaf-f70f-410c-b0a4-9f520a8ac50e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Frederic Raden', '2/23/2024', 3, '1341527793', '261-942-5927', 'fraden3k@twitpic.com', '572d64f3-4d41-429b-95eb-bc2ec8ef92ac');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Randi Kincey', '2/3/2024', 3, '7751468911', '815-551-7321', 'rkincey3l@google.ca', 'f1e39940-ae01-4c9b-98ee-271871b46531');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Orbadiah_check Simon', '3/15/2024', 3, '0976091558', '937-142-9688', 'osimon3m@nsw.gov.au', '1d437a2e-f202-43ab-a2d1-baf396f2d8b3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Luke Gatrill', '7/30/2024', 1, '2052327645', '704-151-4821', 'lgatrill3n@wikia.com', 'b080335f-5e3d-4847-b8f8-a6e4f1857d86');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Keir Dillow', '5/30/2024', 1, '8588966879', '235-770-7329', 'kdillow3o@accuweather.com', '4738a6e1-b4fc-4b15-9129-ff429463a929');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eli Linch', '3/28/2024', 3, '4957322416', '534-294-5566', 'elinch3p@aboutads.info', '71be9d47-bf0c-46e2-aa62-692555f3c3e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Noble Jedras', '8/18/2024', 1, '9789216514', '913-934-4148', 'njedras3q@biglobe.ne.jp', '975f8126-bf96-453e-b919-d22c897a76d5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tammie Clough', '7/7/2024', 3, '8452284966', '217-867-2974', 'tclough3r@comsenz.com', '4a103d79-8294-4e25-bc9e-06ea8f4fddfe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salaidh Arp', '10/19/2024', 2, '1522888077', '989-863-9043', 'sarp3s@youku.com', 'b97ab43f-3f10-407a-ae4e-c6899f1051f9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brit Arundale', '1/1/2024', 3, '1197818583', '165-304-1579', 'barundale3t@wordpress.com', '3a89b3b2-d496-4dee-a96f-7046d9be5d89');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Joey Jeayes', '2/18/2024', 3, '0489022606', '156-422-8564', 'jjeayes3u@domainmarket.com', '3c1e1ab2-f73c-4dfb-af01-9946abe3de63');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Amelia Lansdowne', '2/23/2024', 1, '6039762710', '461-468-6881', 'alansdowne3v@technorati.com', '5cd1e151-7a21-43c6-ba61-e50abfa9bd2f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wanids Jiggle', '2/13/2024', 1, '1334229155', '758-294-8282', 'wjiggle3w@istockphoto.com', '982f333c-6fc8-4b0f-9f20-809748c2ef73');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Damara Donativo', '12/23/2023', 3, '2805230929', '292-454-3189', 'ddonativo3x@last.fm', '537642c9-7b46-4c98-a947-0c2ff72d00be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lion Chismon', '1/11/2024', 1, '3148390125', '928-109-7730', 'lchismon3y@w3.org', 'b9c582c3-4167-4ede-b6cf-419c0a760d96');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Theresina Warmington', '11/8/2024', 1, '9478402637', '125-645-7454', 'twarmington3z@smugmug.com', 'cda40f11-1d70-4156-be87-6eee7615df04');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fredi Jandourek', '1/2/2024', 1, '3144941367', '106-378-8961', 'fjandourek40@cdc.gov', '13d1bcf1-b354-49e3-9ba7-ba1b09c59398');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thomasin Jarred', '1/22/2024', 3, '1805388635', '195-877-2586', 'tjarred41@wikipedia.org', '6ff80a3b-169d-4d37-99db-fdbc74541e3a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vaughan Riglesford', '3/25/2024', 3, '1702156093', '877-808-1509', 'vriglesford42@engadget.com', '9d1cfdd3-4cb6-4243-ae1e-70a91c68bf3d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Desmond Knighton', '4/4/2024', 3, '4211036905', '428-807-9950', 'dknighton43@accuweather.com', '657cd2fc-e097-412f-8834-bf485cce8dcd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Timothea Stickings', '9/4/2024', 3, '2006969661', '508-489-3649', 'tstickings44@zimbio.com', '0f3ac12b-adcc-4936-b613-5813482e5af6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Halsy Spellicy', '3/23/2024', 1, '1787512701', '156-384-6519', 'hspellicy45@google.nl', '2a34d53a-d3a2-4dd7-9919-b52d4990d3cd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kettie Kittman', '1/9/2024', 1, '4129145387', '274-540-9098', 'kkittman46@tinyurl.com', 'bc61c490-5011-455c-926b-4f01b7d9254f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dewey Benning', '12/8/2023', 3, '2826515374', '643-730-1140', 'dbenning47@bandcamp.com', '0281e94e-21b0-44fc-9c78-23503372201d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jeffy Roistone', '9/8/2024', 3, '6207175709', '705-959-4734', 'jroistone48@barnesandnoble.com', 'ab9b24e5-19a3-4fad-b070-ffc7c1c949a4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Phaidra Yushachkov', '9/19/2024', 3, '5648018897', '505-786-3581', 'pyushachkov49@ebay.com', 'd242daba-5121-4f5b-8afd-2db54995a299');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cory Casino', '12/6/2023', 1, '9601348536', '682-527-8921', 'ccasino4a@cdbaby.com', 'c0d5658e-1764-41f9-a6ab-ae4e6cd8beda');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Palmer Englefield', '12/28/2023', 1, '0735337613', '497-478-1903', 'penglefield4b@webeden.co.uk', '29a172eb-870a-4b59-974e-039a8827b252');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jermain Rigbye', '1/19/2024', 1, '3751324712', '718-720-9570', 'jrigbye4c@symantec.com', 'e92ef755-b0de-4f4e-981f-ac03e5d94f08');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Larine Tremblet', '11/13/2023', 1, '5587102712', '815-858-1184', 'ltremblet4d@si.edu', 'b80b567a-5ff5-43ff-8f38-1e31dadf042a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Denys Farfull', '4/19/2024', 3, '0989995352', '184-100-0060', 'dfarfull4e@example.com', '3f876863-dfe1-49c2-b96a-b1c6047f68e8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Padraig_check Sabathe', '12/20/2023', 1, '0869663755', '334-314-2021', 'psabathe4f@twitter.com', 'da939d87-8d85-405e-b90a-f9ac7943b514');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mariejeanne_check Sealove', '7/5/2024', 3, '1513875275', '357-122-0510', 'msealove4g@artisteer.com', '0246370d-02e4-4ce5-a635-18062859653b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Budd Clampe', '1/26/2024', 2, '8078171958', '256-546-4298', 'bclampe4h@mtv.com', '5a5efc65-7c77-4f73-9970-1b5b4e7eec42');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tiffy Cardwell', '3/11/2024', 2, '4172778272', '998-293-7675', 'tcardwell4i@admin.ch', '3e715e3a-67f1-4149-8262-70dd03335a0c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Liz Greenier', '10/30/2024', 2, '7167149597', '125-898-0707', 'lgreenier4j@gnu.org', 'edee3f5b-ae56-45aa-97f0-3fe8a3b60761');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Natala Sibun', '11/7/2024', 2, '6965802123', '485-698-7946', 'nsibun4k@icq.com', '468e6e5c-f7a6-4429-b638-d864a28a2d2f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aurea Laraway', '12/14/2023', 3, '4868596230', '335-441-6357', 'alaraway4l@altervista.org', 'c335107b-5ef9-44f0-878e-877c3455506a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tobe Elam', '1/23/2024', 3, '4270632012', '264-941-8296', 'telam4m@apache.org', '47d9ac91-b052-4aac-84d8-1568932de0ec');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Annetta Grinyer', '9/18/2024', 3, '4608258163', '837-374-6758', 'agrinyer4n@cmu.edu', 'd2d53697-89e0-45b6-895e-ab03a07ec43b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Holly-anne Woolgar', '6/25/2024', 3, '9269911896', '852-337-0169', 'hwoolgar4o@ibm.com', '52009738-f30d-4a5a-a827-83a4c6fcd27f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Reid_check Bullier', '9/5/2024', 1, '6652484715', '548-947-3737', 'rbullier4p@miibeian.gov.cn', '05785d9d-b0be-4409-a286-c2d2721beedd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ally Everix', '11/20/2023', 2, '0002259352', '815-615-8689', 'aeverix4q@pcworld.com', '6d93e91a-3539-4edb-aac5-7fdf0032b0ee');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lyndsay Veevers', '9/15/2024', 2, '6343491809', '111-233-0264', 'lveevers4r@tamu.edu', '21a0196c-8282-47ed-8815-ac4d9ce82829');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosy Bidewell', '8/15/2024', 2, '2787589570', '733-332-9122', 'rbidewell4s@miibeian.gov.cn', '9770d896-6e5a-4222-9aed-2ad7ca4b54d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Noah Starte', '12/20/2023', 2, '7623473343', '989-184-4299', 'nstarte4t@pagesperso-orange.fr', '99365a76-4d83-4203-98c8-44442c97bccc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Veronika Ivimey', '12/8/2023', 1, '0451584825', '488-528-1721', 'vivimey4u@xing.com', '14e9f4e0-57ce-4f8e-a0b9-04a7cc65c4e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Felix_check Buntine', '1/6/2024', 1, '4033908761', '715-725-6176', 'fbuntine4v@cam.ac.uk', 'd8a38235-db47-48f4-be9b-9c5b758a02e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kaylee Tonn', '11/12/2024', 2, '1887328762', '464-233-7008', 'ktonn4w@google.com.br', 'dd627ba5-a600-4365-b1eb-d93aa8496829');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Roseann Thomsen', '7/6/2024', 3, '2539586744', '326-146-7055', 'rthomsen4x@dell.com', '3318dbd2-c6ec-41d0-846f-17cebd3cdfd1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Artemus Foster-Smith', '11/1/2024', 1, '9890657734', '147-288-5684', 'afostersmith4y@weibo.com', 'bb3ca8ef-bdf0-4d7e-a2bf-4e33873ffb68');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mersey_check Grady', '11/21/2023', 3, '2846602778', '512-684-0772', 'mgrady4z@apple.com', 'c215cbc2-b3a5-4a25-98a5-6df162ea99dd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Octavia Fowells', '7/8/2024', 2, '3114127508', '960-502-2001', 'ofowells50@tinypic.com', '6ec67023-2650-4942-b728-d170095639bf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Woody Ferries', '4/15/2024', 2, '6610749167', '408-465-9222', 'wferries51@msu.edu', 'ae9b7351-754e-4740-8afe-ac1293d9e86e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Devin Kirkness', '3/14/2024', 2, '5279243085', '127-506-6753', 'dkirkness52@umn.edu', '6476092b-d69b-4055-ac9e-c423cc86ca31');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Steffane Mayston', '12/4/2023', 3, '0310374203', '702-674-5220', 'smayston53@berkeley.edu', '4517ffe7-1e94-4699-891c-24852c2daf44');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Desmond Rathjen', '10/9/2024', 3, '4970723224', '368-471-9374', 'drathjen54@ask.com', 'f853725a-6713-4f23-9821-f34bbc9afbf5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dicky Cheltnam', '5/27/2024', 3, '5732044863', '569-437-0595', 'dcheltnam55@tamu.edu', 'da5beef3-31be-41ff-9d81-2005398e4eed');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ailbert_check Sinclaire', '3/22/2024', 1, '2213852989', '689-785-7642', 'asinclaire56@webmd.com', '18ddb915-b597-4cb1-b75b-0c0aede3cf41');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Benedikta Hutsby', '7/22/2024', 3, '2645216322', '707-935-1832', 'bhutsby57@edublogs.org', '5be46039-89f4-4b27-86f8-7c43469075d8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ferd Graal', '4/30/2024', 1, '4690717499', '749-110-2886', 'fgraal58@goodreads.com', '7e750534-79c2-4da6-9581-003d2189c934');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Morry Arnhold', '4/8/2024', 1, '8757100686', '334-479-0771', 'marnhold59@cbslocal.com', 'cf091323-47dc-4434-aee7-5627fb800370');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stepha Monget', '12/27/2023', 1, '8467383726', '105-931-4950', 'smonget5a@businesswire.com', '6ba4c469-176e-4d94-8218-8592b02c9b37');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lisbeth Bagott', '6/16/2024', 1, '7926428722', '580-410-0306', 'lbagott5b@si.edu', '18c454a6-e60a-48e1-ae9f-001f15e2d001');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dianemarie Frusher', '2/18/2024', 1, '7657059189', '587-895-5207', 'dfrusher5c@last.fm', '9aa52f12-b4d4-4fb1-933d-9ce316a6670e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lesya De Meyer', '1/16/2024', 3, '7685162648', '483-202-4630', 'lde5d@boston.com', '6e85a2a2-ba62-4272-b984-fbeca50641d1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nert Keningley', '4/20/2024', 1, '4550183341', '527-722-7678', 'nkeningley5e@sogou.com', '0314c898-e519-4026-8274-8bd701c9b9a2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Julee Baston', '3/14/2024', 2, '4359328557', '383-561-8180', 'jbaston5f@cafepress.com', '8fbe610a-00e2-4100-8b3c-13f07d6a2e1c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wilhelm Devlin', '2/13/2024', 3, '4803010243', '212-589-6816', 'wdevlin5g@alibaba.com', 'c2c359f8-2c28-4f9f-a473-b7b73e4124bc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Helsa Alven', '9/7/2024', 3, '9088002806', '454-997-4309', 'halven5h@msu.edu', '4db3a313-4923-4cdf-abaf-e4b40a694d26');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Glenden Sinott', '3/25/2024', 1, '3793271851', '394-139-0447', 'gsinott5i@squidoo.com', '9e41ef77-20d4-4fa0-8c1a-ea768549a11f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clare Riddett', '5/29/2024', 1, '1772410714', '900-687-2057', 'criddett5j@nationalgeographic.com', '62f468bd-877d-49b3-9a88-d5ed8c944ca5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Forrester Van Velde', '1/16/2024', 3, '6862434044', '984-213-4465', 'fvan5k@bravesites.com', 'ce7961d7-5c89-499c-9778-bbe74b28bf56');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kristine Pethrick', '3/28/2024', 2, '9809423710', '306-920-7225', 'kpethrick5l@blogspot.com', 'b68f6b7b-290d-4c23-bcfe-5f22a0138b88');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jennilee Aughtie', '6/20/2024', 1, '0067830801', '822-435-2404', 'jaughtie5m@usatoday.com', 'd642c88e-a930-4f98-a0a4-ef8daa0c374f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vince Dobbin', '7/31/2024', 1, '9640779826', '196-972-0989', 'vdobbin5n@umich.edu', '24608636-33b8-4805-bd51-d72ccad2dc28');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gallagher Rieger', '3/25/2024', 2, '1270418826', '189-855-4099', 'grieger5o@example.com', '20022817-4860-4659-9cc1-58aafa5e144f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alvina Yatman', '3/10/2024', 1, '7934116826', '636-960-3376', 'ayatman5p@jigsy.com', 'e40d309e-3638-42de-88ff-866b354f93f5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cristy Ayshford', '4/8/2024', 1, '3228515176', '685-827-7696', 'cayshford5q@cbsnews.com', 'e0ee722b-1728-40f0-82ef-db0a72b15ab9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dasi Wemyss', '5/20/2024', 3, '7725238549', '344-668-6164', 'dwemyss5r@cbc.ca', '6f5043b3-9cfe-4b96-8d02-2a3568997831');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kirstyn Waymont', '1/29/2024', 3, '4766566239', '844-737-4695', 'kwaymont5s@mac.com', '02bdd538-eb2c-401f-928a-4027858486f4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Robert Coopey', '3/9/2024', 2, '4428479443', '759-369-5393', 'rcoopey5t@sciencedirect.com', '81b27f85-1b41-48c0-87d3-45a670e339c9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eddi Brobeck', '5/19/2024', 2, '4698984770', '455-473-7113', 'ebrobeck5u@studiopress.com', 'aba4d2b0-5a08-4307-8bc8-f79b85d411a8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mel Arpino', '12/29/2023', 3, '2160228760', '512-518-7390', 'marpino5v@cafepress.com', '99add41e-8c81-4bb3-b91b-cc54fa61ef35');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Antoinette Wyatt', '5/1/2024', 3, '7293892123', '790-589-2487', 'awyatt5w@chicagotribune.com', 'efa0f3fe-896e-443e-b922-c0418cce8112');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hinze Jeans', '5/19/2024', 3, '9727208857', '116-543-6272', 'hjeans5x@rakuten.co.jp', '791a8010-ce16-4109-9652-953148d263ee');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lida Schmidt', '7/13/2024', 3, '6627023724', '301-829-1634', 'lschmidt5y@reuters.com', 'fb6012f6-70b4-49c6-a8ba-250d8fd79421');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ofelia Henkens', '4/23/2024', 3, '1192709716', '569-287-5771', 'ohenkens5z@amazon.co.uk', 'cc122e6f-4b73-456d-8eae-29f2b4429a5b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Felicity_check Marieton', '9/30/2024', 2, '3517911895', '873-582-6067', 'fmarieton60@ask.com', '4ed85bb5-956c-49f4-828a-0a876b08c67d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lucio MacDwyer', '4/25/2024', 2, '6261898467', '813-844-8112', 'lmacdwyer61@ed.gov', 'e663c1ac-cebe-45f8-86e6-92c23fce13aa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rafe Kerins', '11/24/2023', 2, '6253130542', '118-760-5492', 'rkerins62@a8.net', '6f7af1a9-7527-4fb8-9534-ba9df475d75d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sammy Keable', '5/22/2024', 1, '1104432168', '308-221-4190', 'skeable63@shareasale.com', 'bf8813fe-4f86-4dd7-9dce-908d02f7d957');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wat Ivanitsa', '7/2/2024', 3, '4335281541', '496-694-4274', 'wivanitsa64@netlog.com', 'eae45792-b84d-4548-ac2f-f3409f8f4d58');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chelsy Fardy', '9/24/2024', 3, '9625773252', '872-759-0917', 'cfardy65@github.io', '318e832a-f5c5-499c-8219-47ddc4608aaa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Halley Yakhin', '12/10/2023', 1, '5596406948', '849-790-1689', 'hyakhin66@homestead.com', 'c028191e-34b2-4ce5-9a2a-708588570aaa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hamid Cantero', '8/16/2024', 3, '7557268248', '112-613-4037', 'hcantero67@hc360.com', 'e62c9996-f482-4a7c-9f86-c9076c832291');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nariko Garraway', '9/25/2024', 1, '2329379615', '349-639-0099', 'ngarraway68@ustream.tv', 'adeeb656-38e1-4083-93d0-e925e8653b35');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sorcha Dafforne', '9/5/2024', 2, '0967836720', '442-746-3273', 'sdafforne69@amazon.com', '84563e8d-3450-4c21-b288-e22c32e2e40f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ali Gwatkin', '4/26/2024', 3, '4160970478', '122-422-5092', 'agwatkin6a@dailymotion.com', '135490dd-0950-4330-8e97-be3ea35e34be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jany Thyng', '6/27/2024', 1, '5800647963', '830-122-9345', 'jthyng6b@nhs.uk', '48a070ff-7b88-43f8-9f02-a0e58e637644');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gerrie Luckcock', '2/10/2024', 1, '7203504005', '536-628-5768', 'gluckcock6c@google.pl', 'd3380e43-1e21-45de-b499-2979335227a1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Myrta Bushe', '9/25/2024', 2, '9382992274', '196-524-7264', 'mbushe6d@printfriendly.com', '9543cc9b-02c1-4632-8e9d-643905ec7020');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Michel Browning', '4/10/2024', 2, '0334926535', '380-497-5538', 'mbrowning6e@weebly.com', '264e3c5a-4df2-43a9-8d45-ec440f0eddf4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Margarita Vaadeland', '1/25/2024', 2, '2057668665', '710-386-4928', 'mvaadeland6f@furl.net', '4e3476a0-8777-4dd7-aba0-58d52e32576f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hermine Dobrovsky', '9/29/2024', 1, '8827577551', '902-318-6701', 'hdobrovsky6g@washingtonpost.com', 'b1cbb4c6-a760-454d-8fe8-fa12ce47ef84');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ursula Brewerton', '1/2/2024', 3, '0975662092', '394-880-5158', 'ubrewerton6h@time.com', '749af190-8bda-47c0-91bc-ec8ad322fa1d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Joel_check Gonzalo', '8/17/2024', 3, '5866765046', '928-483-9208', 'jgonzalo6i@bloomberg.com', '07de36fe-b189-4082-ad23-1a164ada0a63');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Zorah Cartner', '12/14/2023', 3, '0109455475', '557-830-4505', 'zcartner6j@paginegialle.it', '08122860-39bc-4478-94be-8d15eec94b39');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sarajane Churchlow', '8/18/2024', 2, '8808190743', '837-934-3424', 'schurchlow6k@google.cn', '6a349a8e-114b-4a76-bbd7-c6e716020ccb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Heriberto Cassella', '12/16/2023', 3, '3932757405', '338-669-0399', 'hcassella6l@etsy.com', 'c4273a62-2744-40ec-a69e-ca05db005b04');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ella Atack', '1/11/2024', 3, '6890420521', '151-667-7020', 'eatack6m@wiley.com', '9f40a6ad-6616-4d54-98ba-c17545e61f3c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Therine Busfield', '2/28/2024', 3, '8391321939', '923-391-9014', 'tbusfield6n@bloomberg.com', '4ae373f3-77a5-469f-a10b-7abab111adef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Giff Lintill', '12/11/2023', 2, '2428926519', '676-919-9953', 'glintill6o@accuweather.com', '593c7285-61a1-4418-8ccc-9a206e3e212c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katalin Bolley', '8/16/2024', 1, '4884653825', '100-630-7251', 'kbolley6p@nature.com', '7ee5dab2-23df-417e-a460-1b8b9a1fed9a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tommy Coonan', '6/28/2024', 3, '6272710280', '133-422-3479', 'tcoonan6q@github.com', '214b3cda-10a9-4805-90f1-dbe16527ca1d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ferdinanda Baumaier', '7/27/2024', 3, '4656071060', '303-311-1703', 'fbaumaier6r@ox.ac.uk', '2d6406d2-490c-4d2f-9238-9cd96ed17db9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Roderic Scad', '9/19/2024', 1, '7321397740', '839-815-3229', 'rscad6s@patch.com', '023db94d-91f1-42ad-8ef2-fa91cdf4b55e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jeniffer Locks', '3/9/2024', 1, '3828373766', '302-727-6069', 'jlocks6t@wordpress.com', '6343c5b0-8cc1-47c4-8f21-d3dbec3e46f9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Freda Synder', '2/11/2024', 2, '1612465013', '131-666-7707', 'fsynder6u@dot.gov', '6f080662-601e-424c-aaff-3a021b2d3cba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andros Scrancher', '8/10/2024', 3, '5768792730', '840-769-0028', 'ascrancher6v@symantec.com', 'a5f0a32e-07a7-41e7-b60e-fdf58fc383c4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ferguson Crosi', '5/21/2024', 2, '8603561232', '598-734-6903', 'fcrosi6w@newsvine.com', 'c8caa66f-211c-464d-aa53-b80655011706');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ignace Yusupov', '2/16/2024', 3, '3409797207', '547-782-2167', 'iyusupov6x@goo.gl', 'b44dbf7a-2059-4472-a33b-eff4b4d0dd3a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Far Bould', '3/28/2024', 3, '2551306450', '694-312-6141', 'fbould6y@dailymotion.com', 'bb09051e-ce9b-44cb-9225-21b0a7bae870');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fifi_check Luther', '11/20/2023', 1, '3830091038', '349-735-8943', 'fluther6z@g.co', '7626796b-c837-463d-bb59-9dc49c424dd3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Laina Bartot', '6/12/2024', 1, '4216417383', '999-839-8243', 'lbartot70@wunderground.com', '20487786-93cc-4722-b6c1-b8b089a746dd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mathilda Drake', '1/25/2024', 1, '9802071717', '615-579-4627', 'mdrake71@smugmug.com', '3df37d61-9f14-4f66-a1f5-d8b4774e0c3e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Garfield Mavin', '3/2/2024', 3, '4811335167', '318-824-7855', 'gmavin72@harvard.edu', 'b4f293da-43c6-46e8-a540-7d576afad31c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Georgetta Dupre', '10/14/2024', 1, '0907908137', '129-219-4810', 'gdupre73@sina.com.cn', 'cb5a5367-6ac7-4a32-9a1c-013ea6d4cdc3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Franny Maw', '12/10/2023', 3, '6412411991', '654-949-1011', 'fmaw74@washingtonpost.com', 'ff9a42ec-1c63-41de-a517-44bef9b2f0d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shanan_check Pee', '2/25/2024', 2, '4120401312', '264-630-3463', 'spee75@imageshack.us', 'a47e7081-7d99-4984-94fa-acb726c4eac8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Donall Southgate', '3/18/2024', 1, '8346664790', '196-879-3153', 'dsouthgate76@cbc.ca', '9ace5292-4861-46c9-884d-a613831f944f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Roley Nicholas', '8/9/2024', 3, '8091047922', '507-150-1747', 'rnicholas77@mtv.com', '84c7ca20-919e-4080-b617-760b13ab5d56');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Erminie Alexandrou', '10/26/2024', 3, '2567801742', '729-572-5837', 'ealexandrou78@example.com', '69db9411-201f-41eb-9d1b-604221d43a64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mufi_check Blainey', '8/5/2024', 2, '2683470433', '195-937-8506', 'mblainey79@digg.com', 'ab010db2-41e8-46c3-a0d8-6e01992f57ad');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kristine Eglise', '4/13/2024', 2, '3962054063', '234-984-2980', 'keglise7a@bloglovin.com', '7c8cf33d-88be-4494-ab63-b2124fcc8542');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Westbrooke Meake', '2/15/2024', 1, '9009422535', '839-947-6471', 'wmeake7b@uol.com.br', '64663c61-2859-4ce7-9c87-301cd5a79c2a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Essy Goff', '7/11/2024', 1, '9698429094', '850-316-3604', 'egoff7c@rediff.com', '39c5c696-b101-4865-b8f1-9794ebae5cb8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jessa_check Guess', '11/9/2024', 1, '8285444065', '757-108-0636', 'jguess7d@imdb.com', '18d907e6-04ef-4b5b-9e44-91acb74a0296');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Martie Bennion', '6/27/2024', 2, '8445328044', '906-467-9950', 'mbennion7e@symantec.com', '3e0e54e9-1cfc-4f53-8f44-0b8ac0518c54');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jenine Boone', '12/16/2023', 3, '1098711642', '113-974-9347', 'jboone7f@indiatimes.com', '852ab1b7-fd89-40fd-85e7-b5bacc8ea4ef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kylen Nellis', '4/24/2024', 1, '9499202530', '932-218-7007', 'knellis7g@si.edu', '2d3ac3bf-f9bb-48bc-a145-59013d14865d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Maison Alti', '9/23/2024', 2, '6536067653', '194-179-7058', 'malti7h@pagesperso-orange.fr', 'b4baf1f9-cbad-4a8c-afc3-632e52c2bd15');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clemmie Saggers', '3/8/2024', 3, '2696807095', '457-478-2624', 'csaggers7i@intel.com', '4a898fb4-0c80-4563-a185-2c22eb5e0259');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cortie Andrin', '8/11/2024', 1, '7716622040', '802-508-9180', 'candrin7j@usa.gov', '2b100180-2702-4e0a-b608-4ac9150ee962');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shannon_check Arendt', '7/15/2024', 2, '0679238657', '994-564-5936', 'sarendt7k@freewebs.com', '5c852652-7068-4a67-a87d-eb1517ef3d77');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nilson Facchini', '8/25/2024', 2, '9802850025', '469-749-8989', 'nfacchini7l@reddit.com', 'c164221c-df3c-4496-a80b-4d2ece0d8b07');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Enrica Rowland', '8/15/2024', 1, '1483440800', '362-448-0932', 'erowland7m@wunderground.com', 'fac6424c-13c7-465b-b553-934ea0f37dc8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Erskine Bannon', '1/8/2024', 1, '5382707734', '344-672-7976', 'ebannon7n@independent.co.uk', '3cb04834-f334-434f-9ae2-f447e2db92dd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kellia Carss', '7/22/2024', 1, '7979042818', '867-702-8883', 'kcarss7o@time.com', 'a1610f86-58ec-4ee8-9f1c-df36a67fae1d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ezmeralda_check Deveral', '5/18/2024', 3, '0793278615', '203-971-6949', 'edeveral7p@miibeian.gov.cn', 'f30f9c87-3e5d-4613-91d7-42427b23066e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tiertza Brandone', '5/18/2024', 2, '0008712199', '862-921-5701', 'tbrandone7q@desdev.cn', '8cf90b63-93c0-4df1-909d-7b570b914942');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Benyamin Waterhouse', '4/6/2024', 2, '2542644788', '758-637-0864', 'bwaterhouse7r@cnn.com', 'af199d85-448a-4759-9530-b0fb09b09c3c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sherwynd Graddon', '6/13/2024', 1, '7746729484', '201-809-7837', 'sgraddon7s@usatoday.com', '8f02ca8d-4411-423d-9c2a-f07f4962e4c4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katharine McHardy', '8/24/2024', 3, '9541892083', '730-132-7563', 'kmchardy7t@aol.com', '40a1c968-2dd9-44fa-9437-a8ff70069be5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hieronymus Colliber', '2/5/2024', 2, '1290526608', '667-686-7901', 'hcolliber7u@washingtonpost.com', '24bd2897-5d80-4337-8b3c-afd144da63c6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jennine_check Selwyne', '1/3/2024', 3, '1327820586', '207-636-0574', 'jselwyne7v@blog.com', '39c73f0f-8d4e-486c-ae9e-5380f3510b05');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Theobald Blackham', '7/4/2024', 3, '8225647715', '265-341-4231', 'tblackham7w@ftc.gov', 'd0f1b576-723b-4a9d-9584-46eadeb1e39b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kermie Grabeham', '8/18/2024', 2, '0069341715', '885-737-2313', 'kgrabeham7x@phoca.cz', 'a94d485f-fcc5-4fc3-8c29-8d0e3c592b53');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hyacinth Shepley', '10/11/2024', 3, '8293316330', '953-808-9313', 'hshepley7y@skype.com', 'a3bf3dda-3bef-4234-842a-7f9dd2ad0365');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Millie_check_check Pickworth', '2/4/2024', 2, '9493367116', '844-990-0510', 'mpickworth7z@guardian.co.uk', 'e4a860ae-fb7a-438a-80e5-6d4f198f7ce2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Edgar Dwire', '4/17/2024', 1, '9007439237', '346-758-1888', 'edwire80@cbsnews.com', 'b16bd59f-1140-45d6-84a8-6e61602e9ef2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dannel Edgeley', '6/3/2024', 1, '1911263914', '564-690-3976', 'dedgeley81@utexas.edu', 'f313827b-6adb-4585-8f82-4b86d7fcb7e4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hortense Carolan', '5/25/2024', 2, '7719731146', '837-792-9448', 'hcarolan82@eepurl.com', '8fb25e80-f5e7-47dc-9530-85bc9e760551');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ronald Glanders', '4/12/2024', 1, '6191980851', '775-613-1033', 'rglanders83@vinaora.com', '49624538-887c-4a8d-8224-6f71689f073e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shelley Gantzman', '9/25/2024', 3, '7807165183', '136-977-5410', 'sgantzman84@microsoft.com', '9e67cc97-46ae-4e54-831c-668514efe8cb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lesli Hunnam', '2/5/2024', 1, '4427859567', '735-130-0608', 'lhunnam85@icio.us', 'bb8cb62e-ed17-4f4a-aaf1-43dc57197606');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Doy Bowdrey', '2/24/2024', 2, '4342390413', '673-830-4826', 'dbowdrey86@ox.ac.uk', '3065a7d5-d035-4bfb-8548-af2f33210249');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Estelle McPartlin', '2/29/2024', 3, '2126870234', '618-735-1659', 'emcpartlin87@jalbum.net', 'ab862a04-fd57-407a-8670-db095492405e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Heath McDoual', '10/5/2024', 3, '3721140459', '518-447-5076', 'hmcdoual88@nature.com', '0ef510be-9b34-485f-983d-76d959b94af6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gregorius Dennerley', '7/10/2024', 3, '7157916883', '116-908-4631', 'gdennerley89@xing.com', 'ac603d17-16bc-4e4c-9700-a9e5e35f2cfe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Culley Tantrum', '6/1/2024', 1, '0293497317', '388-968-9170', 'ctantrum8a@weather.com', 'c71a2f4f-aef0-40ac-af20-c8afa4093830');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dell Penhearow', '11/17/2023', 1, '0591409619', '664-562-9807', 'dpenhearow8b@squarespace.com', '0fb42d03-86dc-4d60-9106-347a9033e60b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eulalie Goldbourn', '1/11/2024', 1, '8454443166', '475-534-0166', 'egoldbourn8c@indiegogo.com', '9235c822-5d05-490a-8059-8f05f0768208');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chelsey O''Hagan', '6/12/2024', 3, '2660982355', '719-901-4194', 'cohagan8d@ihg.com', 'a321e92c-1f53-48b6-9159-dd1b9d72f954');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Abe Fullilove', '7/24/2024', 2, '9042869288', '818-486-2935', 'afullilove8e@jiathis.com', '40256bd5-d674-4e20-87ef-91d2d1e93da5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kim Frickey', '3/27/2024', 1, '5951349303', '314-438-7147', 'kfrickey8f@dyndns.org', '807dfd61-7ffb-44d1-921c-7e6d66ceebfd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mei Bellsham', '6/17/2024', 3, '0375227571', '343-347-4258', 'mbellsham8g@bluehost.com', 'a581f0c1-c8f6-4af0-92de-a18b393071eb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tatiana Bricham', '10/20/2024', 2, '9021685149', '923-471-7820', 'tbricham8h@nytimes.com', '5c6d9069-5a14-4a1f-b55d-5ef26b746942');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shepherd Marrion', '2/28/2024', 2, '0721267788', '271-811-5649', 'smarrion8i@hao123.com', 'a0fa4081-b08d-4dba-a201-d7b42fe43fc1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ade Langmead', '1/7/2024', 2, '8054081134', '337-907-2993', 'alangmead8j@techcrunch.com', 'f969ad81-5560-4aa6-87cb-f381b7bd0cec');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barry Bontoft', '7/7/2024', 1, '4898151924', '868-423-6990', 'bbontoft8k@techcrunch.com', '082ba14c-8fb7-40de-91f6-230e4fa35aaa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fidela Crewes', '6/26/2024', 1, '0073702966', '972-626-2388', 'fcrewes8l@mysql.com', 'b32d5bd9-fbbd-4871-b153-4cf8973ff202');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ewart_check Anglish', '1/22/2024', 1, '2012899197', '106-186-0576', 'eanglish8m@cdc.gov', '72c9275b-ff95-47c8-8e3e-2b61b48aecde');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Yves Leathe', '11/13/2023', 1, '0478914162', '703-770-8749', 'yleathe8n@tinyurl.com', '17436777-7009-4c09-adc2-5db198113a97');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darrelle_check Jaynes', '3/1/2024', 3, '9503753275', '100-595-2274', 'djaynes8o@archive.org', '37865fa6-ed51-4403-baff-c6a326c24529');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aurea Pregel', '10/24/2024', 2, '5200066993', '780-794-0395', 'apregel8p@spiegel.de', '920f4de7-05bc-4b41-88a1-0b88485a002c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shadow Nicholas', '12/7/2023', 3, '3956049660', '676-493-9857', 'snicholas8q@tamu.edu', '6db23776-9143-4542-bb83-ee6a12a6b772');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cordelia Sture', '8/23/2024', 3, '4261922140', '123-570-6128', 'csture8r@fema.gov', 'ed7dd606-f29f-4b8c-82ca-75c065ff300b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Anneliese_check Elstub', '12/29/2023', 1, '8036547428', '137-398-6387', 'aelstub8s@artisteer.com', '7f29091e-212f-44e9-a345-3c5bf9f7081c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tammara Cheek', '11/15/2023', 3, '8356821328', '747-517-2927', 'tcheek8t@elpais.com', 'c8257a23-ca47-45f2-b0ee-6cad0cd0e0a5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Meg Ralton', '10/9/2024', 2, '3136443737', '272-975-5442', 'mralton8u@sphinn.com', 'aaaf5090-44df-4644-9e90-600578817505');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Odelia Bainbrigge', '3/27/2024', 1, '4545670037', '464-762-2259', 'obainbrigge8v@marketwatch.com', '519a7c40-7ef4-47e1-afe3-a21e9ef93a1a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leia Odom', '7/11/2024', 1, '2886916245', '108-572-2853', 'lodom8w@eventbrite.com', '0b2b9bb4-7122-4890-a68b-312890a6086c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hieronymus Tilney', '5/13/2024', 1, '5622216808', '819-825-1754', 'htilney8x@google.de', 'a0a141d3-0fab-433f-b17e-11955fad3669');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wainwright MacLise', '6/18/2024', 3, '5936241878', '821-237-8276', 'wmaclise8y@php.net', '6477d944-afb8-4bb5-8b10-8a97332f5997');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Pascale Ennor', '7/11/2024', 1, '3701897660', '266-801-1660', 'pennor8z@bloomberg.com', '10b5c550-fa71-4dd6-b170-b950de922b52');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ferdy_check Camplejohn', '4/22/2024', 1, '9036531380', '684-274-6673', 'fcamplejohn90@topsy.com', '044bbab9-2c2f-410d-8a9e-f91d6c5f26d8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cari Fausset', '9/19/2024', 3, '0855869767', '548-544-1719', 'cfausset91@ask.com', '7df5fbe4-6203-4037-b03d-4e13cd8a2a94');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Birgit Bosket', '5/2/2024', 2, '1476879025', '403-456-8236', 'bbosket92@seattletimes.com', '30d78b9c-c20c-450c-b0be-38ee223e36c2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bren Gantz', '6/15/2024', 3, '8260605792', '417-166-4092', 'bgantz93@salon.com', 'aa506c05-d7f5-4a89-aa83-db9435759418');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Layton Stembridge', '2/7/2024', 1, '0579052952', '202-616-0259', 'lstembridge94@scientificamerican.com', '639f1955-0ca7-4773-8bce-132aff9f51a2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arne Cutting', '2/6/2024', 3, '1481262696', '109-453-1460', 'acutting95@shutterfly.com', '47b1fc39-ce32-4436-817c-e7a00b257c89');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Abby_check Trevaskiss', '11/18/2023', 1, '0721322287', '785-561-4098', 'atrevaskiss96@prweb.com', 'b52a16ad-c25c-44f2-bdb6-a623684e02b2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Demetre Kibel', '11/13/2023', 2, '6796432071', '433-727-7286', 'dkibel97@hexun.com', 'c332395c-e2ee-461f-b236-1018157f29ed');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Robby Jelks', '6/8/2024', 1, '5205453872', '380-623-9820', 'rjelks98@aboutads.info', 'b65c2bfa-c4c6-4824-a1bd-48322f155cce');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Pablo Garvey', '6/10/2024', 3, '0990093221', '920-809-4855', 'pgarvey99@w3.org', '4aed7838-869d-43fc-98e7-55a4e7a2601d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Giffard O'' Dooley', '7/4/2024', 1, '1257626356', '805-106-4369', 'go9a@xinhuanet.com', 'c5a3b70e-7156-4a9e-ac59-b65eb363b590');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Natty_check Sydney', '1/26/2024', 3, '8019556894', '964-785-4053', 'nsydney9b@sun.com', '6ae1c743-d2bb-4f1c-b586-50e69ad1454a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hayward_check Kropp', '11/27/2023', 2, '7029869087', '727-231-8584', 'hkropp9c@imgur.com', 'ef9ab935-56bc-4857-8d64-73135eb485e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brit Schiefersten', '9/26/2024', 2, '4686343755', '192-822-2364', 'bschiefersten9d@japanpost.jp', '3500009e-4d06-45aa-93fc-7c2dfafecd87');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cam_check Muggleton', '1/27/2024', 1, '7734201485', '908-376-1432', 'cmuggleton9e@ft.com', 'ca0da20d-405f-4857-bcb8-3ca9014e3468');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sherri Hoff', '8/26/2024', 3, '3049314820', '525-863-6776', 'shoff9f@aboutads.info', '1209f1bf-a0ff-4df5-ad67-b104a4f20a45');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mattheus Whereat', '10/1/2024', 3, '9425049094', '664-942-2982', 'mwhereat9g@mediafire.com', 'bbe0a618-e8ce-49b2-90c7-8153397d908f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stanislaus Pengilley', '5/18/2024', 1, '9084154488', '769-858-4471', 'spengilley9h@reuters.com', '3438a83a-5042-4d57-8326-1dcb8cc94655');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darcy Vigars', '8/18/2024', 2, '1136004433', '833-280-3632', 'dvigars9i@booking.com', '002af2ef-4180-4162-b742-6c00e90be060');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jemmie Daintry', '7/4/2024', 3, '4078757692', '350-991-9454', 'jdaintry9j@mashable.com', 'e1e4a739-c1f0-40a7-ab3b-7c0eaaf5ffe4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cyrill_check Hrachovec', '9/25/2024', 1, '3572180349', '722-669-1748', 'chrachovec9k@sciencedaily.com', 'fd896367-b0e7-42f3-9329-f979d0e22b31');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Natal Stefi', '6/27/2024', 2, '8063642525', '828-562-1020', 'nstefi9l@geocities.com', '8486cd96-07b0-4ca0-85ce-f103aa65f6bd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Melony Treanor', '5/13/2024', 1, '8569232263', '811-769-9261', 'mtreanor9m@cisco.com', 'a109408a-6600-4868-af60-a1e79e69fb6a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elaine De Francisci', '10/16/2024', 1, '3815084213', '656-430-8550', 'ede9n@feedburner.com', 'c4709e1f-7737-4b98-8aba-02276ded58b3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Milty Durbann', '6/9/2024', 1, '7030073939', '624-115-7830', 'mdurbann9o@hibu.com', '98517fd5-3f40-478d-a7e0-b4f1441904cb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Belicia_check Snibson', '11/22/2023', 1, '4628666827', '968-277-1879', 'bsnibson9p@free.fr', 'f5af7db8-e020-405a-9c3c-77f2377b8a07');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mozes_check Kieff', '1/9/2024', 1, '2403973942', '659-180-3085', 'mkieff9q@twitpic.com', '9ac0814c-eef9-4df6-8276-6670b356aae2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wittie Brinsden', '7/24/2024', 1, '0765681314', '855-287-5804', 'wbrinsden9r@uol.com.br', 'fa2ef721-5319-48c9-8bbb-3bc30a8e521e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Celina Hassen', '11/14/2023', 3, '0610067175', '641-535-6982', 'chassen9s@amazonaws.com', '748d6d24-e5f0-498c-8470-e823fb6a782f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mureil Anespie', '9/15/2024', 3, '6030976353', '839-258-8482', 'manespie9t@alibaba.com', 'f8e75764-77a7-496c-a1b8-4a723635aff5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aubrey Mcmanaman', '11/18/2023', 2, '0008204751', '739-840-6252', 'amcmanaman9u@zimbio.com', 'ee11357e-3310-4b6b-a919-68691fe0af67');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Johnnie Wakeley', '6/13/2024', 1, '2390171632', '799-787-1737', 'jwakeley9v@go.com', 'a3044026-1325-4339-a986-f13beb02d267');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carlos Hounihan', '6/7/2024', 1, '5710949449', '832-947-8238', 'chounihan9w@studiopress.com', 'e986c41f-0871-4ec4-8547-de8844dfd5ee');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Naoma Satterlee', '9/24/2024', 1, '4446785113', '399-636-0034', 'nsatterlee9x@answers.com', 'f86d30b5-6bb8-4f0c-9ee9-a70ae60d5cd3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clyve Southcoat', '1/15/2024', 3, '4903501579', '724-480-7388', 'csouthcoat9y@yahoo.com', '0eee8eb9-ae29-45ac-a8e4-0e225fe3318a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Garnette Pavel', '7/22/2024', 2, '2635878327', '488-819-6219', 'gpavel9z@dmoz.org', 'ec499ca2-b13a-462b-8af5-2a85a3b5dacb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alister_check Darlaston', '7/9/2024', 2, '2668484127', '670-645-4092', 'adarlastona0@angelfire.com', '481ab784-3a46-4e84-b936-9e848b0c6c57');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eleen Izacenko', '10/28/2024', 2, '2485318879', '134-522-5521', 'eizacenkoa1@nih.gov', '04a78b7f-525e-4282-9a8a-99ec03bb6fa5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vivie_check Cristofolo', '6/27/2024', 3, '7632619516', '489-361-0961', 'vcristofoloa2@tripod.com', 'a7ba3e21-52c9-4c39-bc2d-42ffc9203f5c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lucilia Tratton', '12/23/2023', 1, '9872960154', '582-386-9603', 'ltrattona3@drupal.org', '133910eb-51e7-4e2e-b119-d5bfb31c0655');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Paula Dimmne', '2/7/2024', 2, '2693115937', '128-648-2472', 'pdimmnea4@icio.us', 'd3d3acf9-32a2-4d88-b5d4-7de87039ca10');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tiff Chieze', '12/9/2023', 3, '9433267152', '866-662-6547', 'tchiezea5@fotki.com', 'a94d0d4d-821b-490a-8040-9c02e7d74b53');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dana Vany', '5/1/2024', 3, '2848004507', '776-215-3838', 'dvanya6@vk.com', '6fb4637a-ca69-498d-83e8-e1adedcf486f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Northrop Costello', '8/31/2024', 1, '3543465534', '920-986-3717', 'ncostelloa7@liveinternet.ru', '1b883378-5c55-4760-ae73-a9962de85c86');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Basil Madge', '11/5/2024', 1, '2084673068', '937-913-7236', 'bmadgea8@bandcamp.com', 'db85a984-90a3-4c93-932d-60ebe8c1d47e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Maddy Fritz', '7/20/2024', 2, '0932129831', '173-875-9312', 'mfritza9@de.vu', 'bbea27fe-0e89-45e7-a334-c838ace80772');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Victoir_check Giraudou', '9/14/2024', 2, '9134620359', '839-825-9973', 'vgiraudouaa@bloglovin.com', '75849520-8c55-4c15-90a2-bb4cde8d0b1b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dallas Ketch', '12/27/2023', 3, '3700699502', '392-476-9256', 'dketchab@boston.com', 'ab6eed64-51a6-4330-b23a-d79e65bc2ae0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tamarah Bolger', '11/9/2024', 1, '6836317374', '326-762-0812', 'tbolgerac@edublogs.org', '72b16a98-7193-4402-b292-eb181f6989b4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Garrek_check Dougharty', '12/19/2023', 3, '2391563674', '450-766-1770', 'gdoughartyad@vimeo.com', '1fb3c9bd-c275-405f-b077-68bb6aba7a88');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lynsey Rasper', '11/17/2023', 1, '7385459524', '783-207-6273', 'lrasperae@nydailynews.com', '42774e8a-bc02-4471-8726-cee8c74f6029');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fanchon Claire', '2/11/2024', 2, '7354478027', '880-337-9482', 'fclaireaf@edublogs.org', '381fd402-f770-4010-a311-c3b245fc7eb8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dugald Geroldini', '12/30/2023', 2, '5664504214', '730-127-0928', 'dgeroldiniag@businesswire.com', 'b3e914bd-74bc-46b0-bf04-acd68bcc22b9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosita Haensel', '4/16/2024', 2, '4114095983', '785-168-3744', 'rhaenselah@go.com', '6fd9f4e1-eb58-43e4-9011-1dbc5e6efccf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Constancy Senussi', '9/12/2024', 2, '2936890047', '680-110-1600', 'csenussiai@goo.gl', 'f39aef16-f579-40da-965c-13cc257c5346');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Padget Jaffrey', '6/25/2024', 3, '5405151173', '600-258-9850', 'pjaffreyaj@mediafire.com', 'fb814f9c-9fe7-48a0-bce9-4355850d0bf4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brooke Vink', '4/9/2024', 2, '1276616842', '415-183-1243', 'bvinkak@cafepress.com', '54712c3e-d1c8-48c0-ae1a-78d1b792a776');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Othelia Celier', '7/31/2024', 2, '0188005367', '238-155-8985', 'ocelieral@cnet.com', '6677bd7b-bbcb-49b6-9b36-9e29c6b357f7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bethina Pressman', '2/25/2024', 3, '1320713325', '736-509-9827', 'bpressmanam@nasa.gov', '487bf71d-15ef-4294-b23d-9410f966e9bc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bron Keoghane', '11/19/2023', 2, '6703840624', '205-374-8823', 'bkeoghanean@ucla.edu', '90fd1f7d-0a90-4e47-ac4d-db824b01a272');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Muffin Dicker', '11/7/2024', 1, '8735202203', '221-178-0008', 'mdickerao@stanford.edu', '8f519e26-b93e-4a71-a867-d56420e86201');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Purcell Estoile', '6/3/2024', 1, '1445524591', '500-712-8282', 'pestoileap@a8.net', '55335f5a-8e4c-474e-aaca-f3769814a588');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hanan Vampouille', '10/15/2024', 3, '2860679175', '990-509-2166', 'hvampouilleaq@people.com.cn', '03f31ae5-fcc6-4a5b-b8e8-6d581d130452');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clive Drakeford', '6/9/2024', 3, '4832135052', '365-322-8085', 'cdrakefordar@businessweek.com', 'b3d85300-8ac2-4f9c-a6e3-ec00db339fdd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Casper Boxill', '8/20/2024', 2, '3500941458', '986-130-7215', 'cboxillas@cnbc.com', 'f1d9595d-aab8-4870-b187-84eaf3f0c20e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sissy McGlew', '1/28/2024', 3, '6173800054', '588-805-8687', 'smcglewat@ox.ac.uk', '7108f798-8e57-4127-a572-fbda6b402764');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ric Tape', '4/5/2024', 1, '9520416112', '603-884-5767', 'rtapeau@jigsy.com', '23e0c7ff-56ab-482d-81a4-38bb1f406a2c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Belita Holleran', '12/10/2023', 3, '7079690638', '887-141-1220', 'bholleranav@wired.com', 'b503290d-4480-4720-ab1d-8af6aa50a6af');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Toiboid Rushmere', '6/16/2024', 2, '1261564924', '878-321-8622', 'trushmereaw@latimes.com', 'dd5df4d4-32e4-4fd6-8245-f67e09bca638');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rob Reap', '10/27/2024', 1, '4222703128', '647-731-3596', 'rreapax@usatoday.com', 'ec49e056-433f-4999-8ddf-e3a1ea3bd7ea');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Renate Elms', '6/30/2024', 2, '8547880780', '887-843-9387', 'relmsay@ifeng.com', 'f6b90b7f-4452-4d38-aaed-98985d9ac5df');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Martainn Neilands', '1/25/2024', 2, '1047829659', '342-541-8807', 'mneilandsaz@nymag.com', '2b3d3609-ee6d-40d7-87ef-2dfe62fb7c42');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ari Pietsma', '7/2/2024', 2, '6493787147', '914-316-6151', 'apietsmab0@nba.com', '71568dc6-e331-426e-b0a5-c8a9b6a3db2a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thomasin Cokely', '10/24/2024', 1, '0241508916', '195-630-4076', 'tcokelyb1@wp.com', '4a89e62a-27eb-4393-927d-d8777cf549f6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nina Rawlings', '10/26/2024', 1, '5830087747', '266-504-9246', 'nrawlingsb2@scientificamerican.com', 'f000f7db-69b9-4948-b18c-624224cca285');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ilene Georgeot', '3/2/2024', 2, '2145976665', '887-893-7294', 'igeorgeotb3@google.de', '55e2c5da-6b07-4186-9452-dd4a4fdd75aa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cos Bosson', '11/23/2023', 1, '8311296418', '395-548-3259', 'cbossonb4@parallels.com', '020767f0-7a32-410e-a80f-9946a55f697e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fowler Davenell', '5/11/2024', 3, '2709013736', '526-468-3709', 'fdavenellb5@seesaa.net', 'd62dc145-7fa9-481d-b9b2-683699f1fa9e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arlina Rosenvasser', '9/20/2024', 3, '5355286904', '769-106-6584', 'arosenvasserb6@domainmarket.com', '0728e0c1-e60e-4e08-b09f-7a4b15ceddff');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Farica Stebbings', '1/8/2024', 3, '4016495028', '910-110-9123', 'fstebbingsb7@fc2.com', '27fd8da9-8b81-4db2-8add-c99332dad935');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leta Inker', '4/9/2024', 3, '0218592618', '317-135-3976', 'linkerb8@adobe.com', '252dedca-eb0e-4bd4-9a84-50cad01384a3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Martynne Furtado', '3/25/2024', 3, '6598461753', '406-668-3908', 'mfurtadob9@acquirethisname.com', 'b033f940-ad25-43b9-a104-f74d64811986');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Doy Videan', '6/23/2024', 2, '8861642261', '361-390-6178', 'dvideanba@list-manage.com', '53c8e330-2bf0-4a7d-837e-3cd65667fbd2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stavro Ratnage', '10/7/2024', 3, '5552867833', '985-210-3839', 'sratnagebb@cornell.edu', '3b29dcd8-f307-4e46-8d72-964467c86d57');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Josefa_check Ridhole', '4/18/2024', 3, '8201605314', '200-127-4087', 'jridholebc@army.mil', '46b98df2-3327-4296-b9d7-2c4b7bff346c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Horatio Whittleton', '9/7/2024', 3, '4397864320', '161-256-0444', 'hwhittletonbd@marketwatch.com', '7432853b-1fd1-4684-8209-7307c0d0657f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guthry Dosdill', '1/1/2024', 1, '0771656041', '376-509-9252', 'gdosdillbe@deviantart.com', '825de9f1-e585-4adc-8902-de43af2c5ddb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clemmy_check Duffield', '5/25/2024', 1, '6950141829', '866-674-5659', 'cduffieldbf@dagondesign.com', '55ff28d2-e7a4-4e49-b6b5-deb69b9d06a5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Marianna Ingley', '10/28/2024', 1, '9747319891', '608-415-9279', 'mingleybg@theatlantic.com', '6f16ffbb-f5ef-40ae-bc3e-9e90f73aad43');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ivory Shemmans', '8/25/2024', 3, '9841025155', '812-800-5157', 'ishemmansbh@utexas.edu', 'debfe355-92e7-4d32-a7de-384c02f206e7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Judi Kid', '5/28/2024', 2, '3526706705', '560-837-5269', 'jkidbi@naver.com', 'c8249a30-e85c-4bd8-ab50-1b2c93289056');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mikael Gavrieli', '11/2/2024', 2, '9030942223', '379-976-2282', 'mgavrielibj@prnewswire.com', '343bc865-e6aa-483a-9c50-3cabcbacdc01');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wanda Dalyell', '11/9/2024', 1, '8201188130', '504-691-1278', 'wdalyellbk@exblog.jp', '79f9db51-199c-46a8-bc02-26e6b51e1186');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Izzy Fallens', '2/23/2024', 3, '5045245048', '644-423-8871', 'ifallensbl@liveinternet.ru', '7019ff6c-923d-4210-9148-5fbf4b745366');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fawnia Wilkes', '1/19/2024', 1, '4160747294', '458-968-2969', 'fwilkesbm@japanpost.jp', 'ea3b96f1-2310-4a73-86fd-9109c1a1149b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ingemar Danihel', '3/5/2024', 1, '2897098888', '564-144-8607', 'idanihelbn@accuweather.com', '2d6b3bbd-65da-4459-8fe2-11bd448665cb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Perla Hassell', '12/26/2023', 1, '9760847129', '469-179-5546', 'phassellbo@pinterest.com', 'f107ed3e-5a9f-437e-ae08-78847e899267');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Conan Brinson', '10/13/2024', 3, '8031180837', '205-357-1118', 'cbrinsonbp@naver.com', '5b5c4943-57f1-496e-ad12-34d41e260986');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Harald Gasson', '2/23/2024', 2, '9577262037', '519-499-7131', 'hgassonbq@ibm.com', '63f435b3-bd49-4916-88a9-0e46ff56d0c8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('William Gronno', '11/4/2024', 1, '0948428243', '713-218-8232', 'wgronnobr@facebook.com', 'af132c29-d691-4afe-b286-5f569be93e9c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Malinde_check Pavlik', '10/4/2024', 3, '8012497149', '342-436-5482', 'mpavlikbs@rediff.com', '355477b4-2d69-4488-a15f-b67c4d089b33');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katusha Saleway', '4/19/2024', 2, '7942818739', '644-489-0505', 'ksalewaybt@nasa.gov', '4dffa1c5-fd89-4ddd-97e9-d615ae23c811');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Beaufort Hedling', '12/6/2023', 1, '0647673137', '329-788-3319', 'bhedlingbu@earthlink.net', 'c07575ba-abd6-4501-9a88-8a1b01781a64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nevile Stendall', '6/3/2024', 3, '4227423816', '593-653-9197', 'nstendallbv@sogou.com', 'c87e0986-1fac-4311-9e29-a31fb45ad091');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Misty Merriott', '7/3/2024', 3, '5757457171', '678-452-5511', 'mmerriottbw@washingtonpost.com', '83d75c97-a032-414c-9b75-705e19afa6b0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ainslie Howlett', '3/26/2024', 3, '8940492102', '997-517-1377', 'ahowlettbx@economist.com', '8c34dbf4-f3d9-4038-bf0c-b0f85256d92a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Curry Navan', '12/13/2023', 1, '7389544646', '398-187-5766', 'cnavanby@cbslocal.com', 'fecf9c41-ad92-49f4-8d62-d29308836433');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Albert Titmus', '3/8/2024', 3, '7925504466', '525-786-0620', 'atitmusbz@fc2.com', '8a11006c-4f0a-42c6-a3e4-35eb325287b9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Briggs_check_check Brason', '5/11/2024', 3, '3235377193', '736-683-8764', 'bbrasonc0@thetimes.co.uk', 'c0a36b40-af2a-4a74-932b-33cdc0bdb913');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brigit_check Tregonna', '12/10/2023', 2, '5516305539', '258-293-3357', 'btregonnac1@miitbeian.gov.cn', 'b7426ca1-a0bf-4dca-b376-836143fd41e6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mirabella Chicco', '7/31/2024', 2, '8772002917', '527-108-8499', 'mchiccoc2@elpais.com', '92bee718-91bb-40c4-95b8-7eae221ab30f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Johnnie Bilyard', '4/5/2024', 1, '1033564369', '271-596-9957', 'jbilyardc3@bandcamp.com', 'eeefa256-d2bc-4d84-a054-7b21c8f3c904');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darcey Scowcroft', '2/15/2024', 2, '8706288178', '522-495-8895', 'dscowcroftc4@dot.gov', '5b21f2d5-ae26-4e3d-8779-5b9a157c143a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rhys Apfel', '12/14/2023', 1, '8092976072', '958-523-4199', 'rapfelc5@yahoo.com', '8f88d003-7bf8-4d3c-b25a-3183c0fa9084');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Raina Maple', '8/7/2024', 1, '4385699745', '294-668-5356', 'rmaplec6@issuu.com', '24a45cd4-471d-4996-bfbf-8792af8fc3f4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clarabelle Kerkham', '5/7/2024', 1, '1100543889', '707-331-5542', 'ckerkhamc7@issuu.com', 'de08368a-0a0f-43fc-839e-91be128b84f3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Harriot Spenceley', '2/25/2024', 3, '7645700878', '322-849-1475', 'hspenceleyc8@reference.com', '795f49ef-c8aa-47ff-84b0-b844552698f9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Corie Keeney', '4/7/2024', 2, '6772237039', '280-701-5815', 'ckeeneyc9@hc360.com', 'a405efd3-6e08-4ee2-93ef-db386243d3b0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bernelle Cutress', '12/29/2023', 2, '1727102010', '124-213-5178', 'bcutressca@creativecommons.org', '0c252e61-735c-43db-bf28-bdada7b69b56');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kimble Clulee', '9/22/2024', 3, '7746228512', '546-349-2376', 'kcluleecb@nih.gov', 'f8a3d1e3-ae86-4fe7-a9a4-6d4260fe94c3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Devon Roscrigg', '2/22/2024', 1, '7911162315', '439-138-9394', 'droscriggcc@discuz.net', 'a36ff6ab-0411-46a5-a8c1-98ae43e00da5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Donelle Jeffries', '6/2/2024', 2, '4224768207', '564-263-9007', 'djeffriescd@nsw.gov.au', '93bd1643-af16-4d68-8803-167ae2a4a462');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stefan Karpeev', '2/11/2024', 2, '4082977376', '465-403-6103', 'skarpeevce@skype.com', '5d2838e8-ecf8-4bb9-93a4-3651a2123491');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kaylil Barson', '4/6/2024', 3, '6427711466', '260-328-9288', 'kbarsoncf@tuttocitta.it', 'a949f85b-4c04-47f8-b45f-10f52b8ed2bb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Pippa Sodory', '1/24/2024', 3, '9487217234', '923-747-0999', 'psodorycg@bizjournals.com', '9bdaac69-ee3e-4e97-9c2e-5a383f3dc1a3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dale Mulrenan', '4/1/2024', 2, '2667273955', '233-877-0490', 'dmulrenanch@t.co', '54b766c7-307a-4092-a7f4-a42fe11c6860');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Annalee Seery', '11/17/2023', 2, '9091076345', '673-612-9717', 'aseeryci@gravatar.com', 'e87931f2-6ed6-44bf-b5a4-6ba91e538302');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Russell Lomis', '12/1/2023', 3, '2600342305', '389-891-6169', 'rlomiscj@ca.gov', 'dd59af4f-89cc-4806-902c-b1471ce0879d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Garrett Scroggins', '2/23/2024', 2, '0954743590', '317-319-4716', 'gscrogginsck@acquirethisname.com', 'e23f5885-366a-4fa4-b201-1c26b66b32e2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brooks Milson', '11/27/2023', 3, '1352297309', '580-952-7786', 'bmilsoncl@nhs.uk', 'e154f620-71a5-4315-aeab-2f024596b86f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gillie Ratcliffe', '10/4/2024', 2, '2028493285', '189-236-3725', 'gratcliffecm@barnesandnoble.com', 'be1982ed-9da6-4279-b7a0-51fadfac78be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nina Dickinson', '6/9/2024', 3, '2519603791', '550-712-3249', 'ndickinsoncn@ibm.com', 'f61eb3d1-187a-4b86-bdab-3bc97a0edc20');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nealon Carine', '12/14/2023', 2, '8140641190', '963-655-2141', 'ncarineco@unblog.fr', '26fac8c5-7210-456e-bd19-8aea21686b54');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clarita Laborda', '4/11/2024', 3, '5330078063', '559-928-5581', 'clabordacp@360.cn', '08a301aa-82dd-4af0-9dc6-89f15a009019');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Skipp_check Dilliston', '6/17/2024', 3, '0772631926', '210-995-2647', 'sdillistoncq@myspace.com', '73a088b1-851d-4c48-98ff-287253889441');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Naomi Mintrim', '9/20/2024', 1, '0519685498', '774-991-5572', 'nmintrimcr@cdbaby.com', 'd7783b65-babe-4bea-81ce-89cb804a7e4b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lizzie Hovy', '5/15/2024', 1, '9650861810', '565-440-7029', 'lhovycs@sphinn.com', '035420cc-c2f8-4e8b-b1f6-994de70622c6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dorian Tancock', '8/15/2024', 1, '5797160517', '377-298-6158', 'dtancockct@cdbaby.com', 'b6aa4434-a444-435b-9743-619e70268ac3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Olly Filkov', '7/10/2024', 3, '4872468417', '397-112-0189', 'ofilkovcu@macromedia.com', '5368734f-1c3a-49f7-98ce-ee5372206e0e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Taylor Starzaker', '1/17/2024', 3, '9589420009', '319-512-5754', 'tstarzakercv@wordpress.com', '81ae0b30-8a73-46f8-a821-c40a354bf267');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gelya Ferie', '10/24/2024', 3, '3598527101', '810-735-9083', 'gferiecw@mysql.com', '6ccad705-c3ff-4658-bb10-ac251421c174');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darill Shemmin', '5/14/2024', 3, '1056117644', '232-296-7207', 'dshemmincx@apache.org', 'f5f7bab5-85ec-4b25-84e5-c5b845740439');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Daryl Farrens', '6/28/2024', 1, '2027488919', '465-280-3626', 'dfarrenscy@dyndns.org', 'd0ec8173-1f2a-4edc-837a-7698c0e6a12c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aindrea Crookall', '3/6/2024', 3, '7400824440', '871-278-1950', 'acrookallcz@slideshare.net', '31736429-47e2-453b-9ff5-3a5038cb0b8d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elaine Gabler', '11/25/2023', 2, '8185534178', '265-157-1518', 'egablerd0@goo.ne.jp', '4492c362-383a-4bb8-bd22-a5105c3e034c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clare Riddel', '7/13/2024', 1, '1524707751', '913-422-4922', 'criddeld1@rambler.ru', 'd8334f66-b15f-4ea6-bbd7-e339be864799');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Edeline Fairlamb', '5/19/2024', 1, '9871139660', '512-234-9392', 'efairlambd2@harvard.edu', 'b05f8f9b-e9db-460b-977a-3e60685c94e4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mylo Gavrielli', '4/27/2024', 2, '2767907119', '877-909-6395', 'mgavriellid3@japanpost.jp', '581cf257-08f6-40e5-afca-1c89936139b7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vally_check Kilshall', '2/25/2024', 1, '0310171003', '698-198-3385', 'vkilshalld4@timesonline.co.uk', 'ce87e62a-d73b-4920-812f-7612dc2d1e1e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sherill_check Wilsher', '3/18/2024', 2, '8944165884', '305-663-0962', 'swilsherd5@umich.edu', 'bebb5564-c3a2-40dc-8a04-d80886c44ae0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barri Lowdiane', '3/23/2024', 2, '7432329017', '495-580-5362', 'blowdianed6@is.gd', '9c1c86a3-b392-4b05-ae4d-d68ef7b8864a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Haskel Zanitti', '5/29/2024', 1, '0225386464', '223-831-9710', 'hzanittid7@shareasale.com', '56b5a0d2-c6ea-471c-aea1-5a4bee2feffd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Skye Crichten', '8/20/2024', 3, '7832292487', '452-607-2261', 'scrichtend8@flavors.me', '1cd9c3c1-4b77-4b9b-8ffb-516d9d2a9f7e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Morgan_check Canter', '9/10/2024', 3, '8932459428', '287-408-0078', 'mcanterd9@t-online.de', 'ae47f79e-79e4-4e4d-8835-ef9bbb5d6c72');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stace Dearnaley', '10/19/2024', 3, '0172124929', '381-970-2380', 'sdearnaleyda@dedecms.com', '48c7ea24-fe15-4af7-b6ef-bd3f11570fb7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Albertine Greenless', '6/15/2024', 1, '0219971188', '202-691-1017', 'agreenlessdb@msn.com', '07a10c80-f2af-4dad-9c6f-9bc533544c75');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ellerey Elph', '12/10/2023', 1, '9365699195', '652-950-1642', 'eelphdc@archive.org', 'de9cc3f3-9062-430b-9a30-4cf57162129a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carie_check Trill', '3/2/2024', 2, '4815964211', '711-593-0139', 'ctrilldd@craigslist.org', '9e388db1-5f87-411b-bcc5-36551c1f36f5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jo-anne Boake', '6/30/2024', 3, '2863496135', '901-747-5794', 'jboakede@photobucket.com', '44332c5a-0d18-4ef9-bfcf-586bfc8ee262');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Glyn Corck', '5/14/2024', 3, '8998238119', '939-320-0745', 'gcorckdf@addthis.com', '5198dbc1-703c-4444-835a-c249ae5a3bc4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosabelle Fossord', '10/25/2024', 3, '7636378185', '967-302-6665', 'rfossorddg@fc2.com', '60abe710-6102-4ee1-b8a6-24091f658024');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dunc Damerell', '5/16/2024', 1, '5396056757', '178-526-2405', 'ddamerelldh@examiner.com', '7aa1165a-118e-4d9e-8bba-eb12975cd400');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Linet Gath', '1/15/2024', 3, '7806162307', '320-713-3402', 'lgathdi@dailymotion.com', '7e9694f5-d92e-4826-ac5a-41f755b0c327');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sibella Wellwood', '12/9/2023', 3, '6499451067', '680-918-4130', 'swellwooddj@cnn.com', '7b8d676e-de35-4b0d-ae76-d2e40e3536b6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vern Cosgrive', '8/14/2024', 1, '7308279362', '808-514-4617', 'vcosgrivedk@aboutads.info', '089774a7-58c0-4856-ba8d-69a7cec76bbd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mollee Willmetts', '5/23/2024', 2, '0215042721', '182-230-1617', 'mwillmettsdl@home.pl', '31bf7d21-308d-4852-8229-a549cd5a157b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Grissel Redan', '11/14/2023', 2, '0824854316', '287-176-8083', 'gredandm@europa.eu', '954d285c-5680-4a7b-b448-5eb41c15d6d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Paige Castanaga', '8/25/2024', 1, '2427899257', '637-513-7848', 'pcastanagadn@cocolog-nifty.com', '382e76d2-a577-4051-996b-6012c56257bc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Corinne Haverson', '7/22/2024', 2, '2144576377', '353-162-8480', 'chaversondo@pcworld.com', '47c09368-9868-412f-8687-1273047ec29f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leeann Blencoe', '5/9/2024', 2, '5264046869', '345-340-9178', 'lblencoedp@netscape.com', '0248add1-8572-48f5-8019-2b7179eff0f8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kristina Fortin', '11/10/2024', 1, '5685241710', '620-252-2307', 'kfortindq@quantcast.com', '39bf874a-670d-497c-ac63-2c06b2f04d45');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Godfree Heifer', '12/15/2023', 2, '7120842091', '538-578-5934', 'gheiferdr@myspace.com', '5969d2ff-7ac4-4c4d-a293-95a132db4551');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adrea Kidds', '1/27/2024', 3, '0203904907', '878-549-7660', 'akiddsds@europa.eu', 'bf1dd8ef-a891-416a-a228-8530a159c977');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gothart Kinig', '3/5/2024', 1, '1393825262', '168-117-6534', 'gkinigdt@ca.gov', '76abe7af-9887-46e8-b592-72efe6b4ab7a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kellina Muckian', '9/24/2024', 2, '9959875786', '215-637-1365', 'kmuckiandu@netvibes.com', 'b0f98831-4387-4d29-bf6d-d1c46da22075');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Caddric Wannan', '4/11/2024', 2, '0617516630', '321-104-4440', 'cwannandv@google.pl', '84ec6264-eefe-4962-abc7-69ebf0670c41');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bobbi_check Readett', '9/10/2024', 1, '8733525403', '913-885-2545', 'breadettdw@linkedin.com', '7612a779-b12d-4144-a80d-28f7671a6733');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lorne Kamenar', '5/30/2024', 3, '9731199163', '621-698-2700', 'lkamenardx@paypal.com', '593422f4-1c1d-491d-9b43-092e29b26bbf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Debora Lindelof', '6/25/2024', 3, '9958230996', '385-647-2200', 'dlindelofdy@netscape.com', '77b40119-3a13-44ed-bf69-1a0dbf9ae951');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Otis Brakespear', '11/14/2023', 2, '9709825154', '754-140-4678', 'obrakespeardz@moonfruit.com', '889eb876-bdaf-43b0-8fff-bd6c0271198a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kerstin Dawidowitsch', '7/30/2024', 3, '3064798367', '477-446-1245', 'kdawidowitsche0@hubpages.com', '80d54570-09dd-4b61-94ed-9d82232acef9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Avie McCafferty', '9/19/2024', 3, '8278855344', '965-807-3470', 'amccaffertye1@dailymail.co.uk', '675bc2d4-e023-40a2-a2a1-95d53d29de67');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chico Gosford', '3/24/2024', 2, '8522674697', '938-364-4023', 'cgosforde2@oaic.gov.au', '0a863d08-89e4-437c-a183-db57b620a0be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tallulah Bartens', '5/24/2024', 2, '2816108315', '239-943-0577', 'tbartense3@icq.com', 'ab9ced95-2a22-47bb-8066-4f31b4743c91');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gabbie Thurstance', '3/3/2024', 2, '6681739473', '905-466-3103', 'gthurstancee4@cornell.edu', '77c23ca3-283d-4d8d-942b-18cad2825d40');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Billy Mc Meekin', '3/31/2024', 2, '3011100529', '646-605-3850', 'bmce5@feedburner.com', 'fc76936b-a170-43e0-9cc4-7e058b3cce64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arie Rotherham', '5/19/2024', 1, '6944695988', '618-180-5171', 'arotherhame6@nydailynews.com', '4762520e-ad94-4480-a284-ecd1ae9d0955');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bevon Falshaw', '12/25/2023', 2, '6200920182', '520-420-2305', 'bfalshawe7@ca.gov', '28079995-3b8f-4e7b-b4e0-0172b29d6e29');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ashby Kinglesyd', '11/12/2024', 3, '7370028241', '790-936-6037', 'akinglesyde8@tinyurl.com', 'b5bf0ceb-d8bf-4ec4-80e2-bcacf4516987');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tani Ziemke', '8/10/2024', 3, '2354536955', '957-149-8167', 'tziemkee9@pen.io', '3e73b2a7-179f-4877-b90b-b4c07551164c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dayle Baniard', '4/10/2024', 2, '4516031124', '369-982-4130', 'dbaniardea@fotki.com', 'c39f1b11-d4e5-408d-8d15-5ea3c64ad154');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Odelle_check Jordon', '12/16/2023', 1, '9273634598', '777-195-6762', 'ojordoneb@pinterest.com', 'a6bd8d32-fe1f-4753-abff-6eccb559b075');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Meyer Goor', '1/6/2024', 3, '7721079327', '516-198-1451', 'mgoorec@sina.com.cn', '3a039ead-5915-467d-aaff-51fe364b3e86');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Meara Stobbs', '4/8/2024', 1, '4487214047', '235-456-0530', 'mstobbsed@stanford.edu', 'f1d1f3f4-ab9f-49d0-94c5-a26e45e283df');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dieter Andrysiak', '12/11/2023', 1, '4823760399', '317-419-1299', 'dandrysiakee@java.com', '12186004-cb49-4068-ad16-9f2cdce226c8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dottie Roskrug', '5/25/2024', 2, '3072178516', '523-420-0777', 'droskrugef@sakura.ne.jp', '92405fab-27a4-4bd7-a024-3f4b84a6f534');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Towney Tinn', '4/24/2024', 3, '0229617788', '827-749-3573', 'ttinneg@cdc.gov', 'bb13ef6a-b54e-47fe-8e93-9a31bbe4b5a9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ellwood Armitage', '5/11/2024', 3, '9320283705', '231-397-6263', 'earmitageeh@microsoft.com', '10d2938b-cef6-41b1-aedf-724538e712b1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alastair Feenan', '7/24/2024', 1, '5278000240', '466-691-3474', 'afeenanei@apache.org', 'ffa8898e-fe5e-4451-9955-1596d3b03ce9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barth_check Tinker', '1/24/2024', 1, '3517037440', '229-127-5005', 'btinkerej@geocities.com', 'be7dad1b-d0b4-4315-bd09-466292aa1f79');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Paul Stonall', '5/25/2024', 1, '4573578117', '828-883-7991', 'pstonallek@dot.gov', '49792134-7590-4986-a0ef-9b1c58fafd0c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sofia Yakobovicz', '5/29/2024', 1, '4031375617', '799-733-6069', 'syakoboviczel@technorati.com', 'af10249f-59b6-4583-8b8b-aba7bae6fbb7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carlota Townshend', '5/9/2024', 1, '7045451400', '539-218-9384', 'ctownshendem@yahoo.co.jp', 'bb95fb5a-3868-490c-b698-22ea1afdef9d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rand Wortley', '7/18/2024', 3, '8407699201', '651-275-6539', 'rwortleyen@4shared.com', 'e01663e1-08b8-42eb-8170-fb083f28e2dc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cross Checkley', '8/20/2024', 3, '2778469233', '594-885-6602', 'ccheckleyeo@wsj.com', 'e240e316-bf56-4ffc-bc71-c296aa4d5ba6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shelly Mariet', '11/24/2023', 2, '8152776268', '641-116-3658', 'smarietep@4shared.com', 'e0e505fa-2563-47b9-b31e-3d4600d3a428');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chris Baff', '6/9/2024', 3, '3374732821', '978-771-4378', 'cbaffeq@ameblo.jp', '99edf31d-0d0c-4e62-b92f-e596480fc66e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barret Pawnsford', '7/5/2024', 1, '9733830988', '989-225-7584', 'bpawnsforder@sfgate.com', '30c673e7-a1bc-4c24-ab10-e8575b769735');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Florida Gallie', '6/5/2024', 1, '8493305684', '774-359-9363', 'fgalliees@scribd.com', '58edfb87-401a-4d5d-988c-e468e8d3bf50');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arel Brussels', '8/16/2024', 2, '9656409818', '581-402-0828', 'abrusselset@sohu.com', '58aa63c2-925d-4525-a3bb-fb4611e802d6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wade Shipperbottom', '11/15/2023', 1, '4487399363', '747-164-5629', 'wshipperbottomeu@sohu.com', '2bf8fa84-2c93-484a-a983-9365d685d1a9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lucho Wilcot', '4/3/2024', 3, '3517027910', '413-788-2736', 'lwilcotev@sciencedaily.com', '814675ca-3ec3-4275-9db2-1eea038e1fbc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Halley Sycamore', '10/3/2024', 1, '1730588890', '377-799-8661', 'hsycamoreew@ameblo.jp', '62446740-ac11-4a1c-9a4a-aaf905649621');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ada Kynoch', '7/10/2024', 1, '9697795486', '833-338-8435', 'akynochex@joomla.org', 'f7f9f2bf-535b-4a8b-b8a5-c1827eb16a16');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ari Sesser', '8/26/2024', 1, '0837157246', '901-841-4298', 'asesserey@sohu.com', '9f11f516-0344-4e2b-ac1e-dbff6bd360e7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Evelina Holtom', '5/16/2024', 1, '5665134659', '435-147-6720', 'eholtomez@nationalgeographic.com', '9278e3cf-e7b7-4b1d-8ad2-5245d319c47a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Candida_check Butterfint', '1/28/2024', 1, '0293002942', '391-419-6977', 'cbutterfintf0@samsung.com', '6a97df6c-19fb-467c-9e01-441429bfb85e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Derwin_check Flay', '7/26/2024', 1, '4846042285', '972-130-2390', 'dflayf1@marketwatch.com', '2900d10e-f142-4ef6-a956-4f3be4c966b2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eugenius_check Notton', '7/23/2024', 2, '3772556366', '330-410-5122', 'enottonf2@adobe.com', 'd557591f-2791-4d88-a68a-c09a44c47b69');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Maggy McKeney', '4/13/2024', 1, '6105388996', '791-674-7862', 'mmckeneyf3@dell.com', '39c125e7-cffd-4f2e-901e-8462922015d7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Christel Tukesby', '1/13/2024', 2, '6214196533', '132-429-8059', 'ctukesbyf4@nyu.edu', '111fafd1-0600-4aab-b124-756f80124e3a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adolf_check Hurley', '8/12/2024', 1, '6174704792', '774-719-7322', 'ahurleyf5@latimes.com', '9928c752-9912-4bf3-a5c2-7235f896e9f6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Harmon Papez', '2/23/2024', 2, '2001561670', '397-426-1851', 'hpapezf6@columbia.edu', '0f005afd-c567-4e6c-91bd-720406ad507a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bradford Lehenmann', '2/21/2024', 2, '5222586518', '385-308-3992', 'blehenmannf7@gnu.org', '9e5d4e8e-218b-4212-a860-843a30d48cb9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Perrine Pattullo', '3/29/2024', 2, '1024289358', '840-591-2491', 'ppattullof8@symantec.com', '70983271-5da6-43f7-b6da-515e87aa4914');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kati_check Benford', '4/22/2024', 1, '8161866198', '707-940-7773', 'kbenfordf9@discovery.com', '645ed1f7-da55-4a4b-84af-6e6239fa27c0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Halimeda Bertot', '2/17/2024', 2, '9030423416', '520-767-2706', 'hbertotfa@cafepress.com', '0eb64d9d-5ff5-44dc-becb-a967144ca5ea');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Heidie Morrell', '11/15/2023', 2, '1548081419', '977-886-4262', 'hmorrellfb@smugmug.com', '47dfeee6-6063-4b66-88ab-65bc26cff00b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adrian Findon', '10/5/2024', 2, '0395639739', '825-423-4574', 'afindonfc@symantec.com', '4085d05c-a50d-4fa4-a489-f8158bd31dc5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Janenna Corro', '7/7/2024', 2, '0717907890', '329-755-0436', 'jcorrofd@photobucket.com', '68cab6ce-d84b-47e8-9712-08f266dad586');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sosanna Ohrt', '10/17/2024', 3, '2630097082', '614-444-3660', 'sohrtfe@nyu.edu', '30e14ea8-83d4-45eb-aaca-12f83ee4cab5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Margalit Lammers', '9/9/2024', 3, '1107802680', '204-503-2746', 'mlammersff@dion.ne.jp', 'be7b94fc-cab7-44c0-a0c5-7553d3d6d364');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Forest Pragnall', '3/9/2024', 3, '7004729328', '297-886-8778', 'fpragnallfg@ucoz.com', 'c3058309-43c7-4c78-a118-355b8018c819');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Randolph Harring', '2/13/2024', 3, '0401732283', '195-435-5709', 'rharringfh@cisco.com', 'd212efeb-0d58-4246-acd8-a1d7bf0102b4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cullen Males', '2/3/2024', 1, '5552843594', '687-182-2172', 'cmalesfi@mapquest.com', '7cf56705-1933-4fa5-b257-dedec5f9b87a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aveline Meek', '11/11/2024', 1, '1050486379', '456-191-1070', 'ameekfj@prweb.com', 'a31ef0e0-7c7e-4bc0-87f3-6077047aeeca');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Zarla Coughlan', '6/1/2024', 1, '4384770243', '761-618-9198', 'zcoughlanfk@hexun.com', 'ee50e197-e022-4de8-80d8-2f0852c41497');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mamie Maloney', '9/1/2024', 1, '6151836528', '344-329-6445', 'mmaloneyfl@nhs.uk', 'db0c9a98-2ac0-419d-980f-9bf406c1ecba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kennith_check Gerhold', '7/31/2024', 1, '3526243936', '134-248-7157', 'kgerholdfm@ebay.co.uk', '54a3c571-a0fe-400f-9e34-22a8858a1020');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Monti Galfour', '6/29/2024', 2, '0706105114', '983-518-6475', 'mgalfourfn@godaddy.com', '72787da9-ddc5-47c4-967f-df53e2863582');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katerine Kipling', '10/1/2024', 3, '1450086594', '781-876-5913', 'kkiplingfo@sciencedirect.com', '8adddc1a-a360-4f75-87e1-f190e76a4031');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tonnie Scotfurth', '5/5/2024', 2, '3545675378', '121-261-0274', 'tscotfurthfp@twitter.com', 'cdb57565-bf40-4db4-84b7-3df48bcc2e26');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aurilia Dammarell', '10/23/2024', 1, '7549686698', '478-794-8924', 'adammarellfq@seesaa.net', '4e9566f0-c354-4b21-bd81-26b357e5107f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tom_check Shillum', '10/2/2024', 1, '5707093464', '624-367-7182', 'tshillumfr@telegraph.co.uk', '79f94a1b-5478-4018-a187-a4882fbd8e2e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Woody Tring', '10/4/2024', 3, '3968166401', '512-628-2498', 'wtringfs@google.co.uk', '71d410f6-d7be-4d49-af7f-ba55fe6d8a64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jaclin Fass', '6/20/2024', 3, '9780727205', '485-969-2477', 'jfassft@typepad.com', '5b156c55-4fd3-4668-91ac-eeeb9f1e21bc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thane Godfrey', '7/9/2024', 3, '2441902660', '493-332-2422', 'tgodfreyfu@uol.com.br', '465a0d70-c942-401d-ba57-4d7fcab6436a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alex Dabinett', '4/27/2024', 3, '6355558299', '178-611-4379', 'adabinettfv@artisteer.com', 'b2b3a1ce-a7a4-4a7e-95f7-1e9ae624d17b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nicki Pyner', '5/25/2024', 1, '0237591693', '432-863-8002', 'npynerfw@spiegel.de', '251c4903-c6f1-491e-9670-7b6e32c39c2e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Murdoch O''Halleghane', '8/6/2024', 3, '0300939929', '232-663-6445', 'mohalleghanefx@free.fr', '3a176821-1766-4e84-af59-740524615bca');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emera Bear', '10/25/2024', 2, '9450763762', '768-239-3020', 'ebearfy@i2i.jp', '3777a248-ec50-477b-90ad-8724b2017263');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carmelia Cornbell', '5/28/2024', 2, '3954546293', '801-192-7835', 'ccornbellfz@sogou.com', '9efd7af5-e3d0-43d1-b44c-3d11c13febe5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kipp Greatrakes', '3/29/2024', 2, '6130317002', '224-416-0752', 'kgreatrakesg0@biglobe.ne.jp', 'c9c3cc51-d078-4917-887b-e482e2753e6d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shaine Oultram', '11/20/2023', 2, '0172720575', '782-136-7607', 'soultramg1@microsoft.com', 'd15fd050-2de0-4c68-a8e2-bcd108b5526f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Benjamin Pierucci', '3/17/2024', 2, '1684664236', '443-275-2806', 'bpieruccig2@reference.com', 'c3db0c73-d740-4756-8e7a-4edf089bfaaa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guntar Yeabsley', '5/27/2024', 3, '0268254568', '434-161-9526', 'gyeabsleyg3@guardian.co.uk', '55175a21-e59d-476b-a91c-da23fa74268f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salli Sysland', '11/12/2024', 3, '9425304062', '669-105-1045', 'ssyslandg4@fotki.com', '1ac9bfbb-d1e1-4dd3-bce0-3cc31945844d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tally Enderlein', '11/1/2024', 2, '0338486912', '654-751-5619', 'tenderleing5@ebay.co.uk', '96ef30f8-1c09-48e7-9500-34e3d7a34a9b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Caren Egdal', '12/22/2023', 1, '9016429746', '623-412-9518', 'cegdalg6@wordpress.org', '2ae03a59-53ae-4827-8cda-9dd6a518121d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kayne Deschelle', '12/16/2023', 2, '2682882000', '573-998-8983', 'kdeschelleg7@google.ca', '79d80954-9ef8-416d-8ec7-24c060c399be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hulda Swigger', '4/10/2024', 1, '7495758885', '479-999-7178', 'hswiggerg8@php.net', '27aa0691-eedd-4225-874d-dca39173b008');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lory Mattiassi', '5/28/2024', 2, '2357628062', '842-866-7235', 'lmattiassig9@a8.net', '9183929e-ae77-4d97-a9dc-d98d41bb6b5f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Starr Wildin', '8/5/2024', 3, '1524424843', '986-732-7058', 'swildinga@netlog.com', 'f99fe3b1-a4c3-43d5-b17e-07af122934de');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Corabelle Comini', '9/27/2024', 2, '0711005265', '144-647-3855', 'ccominigb@sphinn.com', '1b5e87af-b2ab-47d9-8199-02e18ae24b50');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mariam Antonovic', '10/8/2024', 3, '0847867114', '697-640-1382', 'mantonovicgc@princeton.edu', 'aa863c9d-8eed-4043-9e52-4d9844a3223e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mitch Geerdts', '5/25/2024', 1, '2206668633', '977-666-5244', 'mgeerdtsgd@github.io', '6647ad27-1ab6-45b5-83a8-96730a65f25e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guillermo McGaughey', '5/2/2024', 1, '4324811595', '937-644-7352', 'gmcgaugheyge@theguardian.com', 'b74f2795-af9f-4431-b616-891f38611c6c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kylila Hulls', '3/14/2024', 1, '6341582063', '941-355-5170', 'khullsgf@dailymotion.com', '6bc0e663-0f87-443f-ad10-00cd6f65f34e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mandel Sunderland', '10/19/2024', 2, '7068962761', '264-999-1124', 'msunderlandgg@gov.uk', '231c3dc6-3bd0-4850-9c2d-1d7b88cede54');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ellwood Tidswell', '7/7/2024', 2, '8425858902', '559-915-8302', 'etidswellgh@bbb.org', '17908222-2b34-4802-9ddf-e040cc2bb526');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kissiah Blabber', '8/20/2024', 1, '1805536249', '483-298-5621', 'kblabbergi@google.it', '8788068d-1c49-418f-9e2b-11697ea787a1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elana Emney', '1/19/2024', 1, '4351311786', '940-699-9934', 'eemneygj@symantec.com', '3f82dc64-f1cb-4752-abff-044b66893ecf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Natassia Cammack', '11/3/2024', 1, '0099133806', '496-510-1797', 'ncammackgk@reference.com', 'ad040f49-25d1-4744-afdd-420e21333924');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Margalo Rowlatt', '7/23/2024', 1, '7502196468', '849-706-1360', 'mrowlattgl@last.fm', '20a97610-a12f-4cfc-b267-135810e57313');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hew Christophle', '2/8/2024', 1, '9437906973', '484-450-8844', 'hchristophlegm@ovh.net', '6fac9709-5c7c-4656-b326-de4032a71bc6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Celestine Moggach', '5/8/2024', 3, '7577726042', '180-832-7418', 'cmoggachgn@ihg.com', '70c5f01e-c193-41f0-bb30-aca81e869c22');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ardith_check Pople', '11/23/2023', 3, '8937719238', '122-872-8029', 'apoplego@sina.com.cn', '9f58c2e3-97a8-42f9-bde1-bffa934602ba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lynnell Toretta', '2/24/2024', 2, '7845423929', '759-962-4437', 'ltorettagp@comsenz.com', '1090bac7-c85f-44a2-8dfe-47e9eb7e9712');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bernarr Mussared', '12/22/2023', 3, '3254824183', '797-474-3411', 'bmussaredgq@pbs.org', '1d465d28-8f59-4fe8-a7b6-12dff89dd828');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jorge_check_check Heugh', '1/19/2024', 3, '8898999256', '317-169-3650', 'jheughgr@usatoday.com', '20f816c9-13e8-4273-b735-31fe8b851635');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Broderic_check Cotte', '3/15/2024', 2, '7459012991', '753-774-5987', 'bcottegs@amazonaws.com', '1bfea2af-c46b-408c-ad54-62ad6214b226');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nicki Van Zon', '7/7/2024', 3, '8940802876', '181-367-1469', 'nvangt@plala.or.jp', 'c0e42f0a-6bce-4e18-96c7-5156d5fad006');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Heather Francomb', '3/20/2024', 1, '3815949225', '780-143-6397', 'hfrancombgu@blogger.com', '23985c52-a4cb-4bc7-9b0c-711ec94928c7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Othello Perry', '8/29/2024', 3, '6512167710', '411-283-1066', 'operrygv@cocolog-nifty.com', '6825d576-7adb-4236-94de-2132ba1b6c0d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Peri Berndsen', '5/12/2024', 3, '3346502787', '893-604-3641', 'pberndsengw@odnoklassniki.ru', '3dd732ab-07f8-4cf0-9aa3-e87313d2778f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jilli Danielli', '12/28/2023', 3, '3771332529', '606-721-2254', 'jdanielligx@wufoo.com', 'b1ad5c98-5716-4836-818f-e383d721617b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Worthington Band', '5/17/2024', 2, '4843992754', '177-193-2565', 'wbandgy@mapy.cz', '653bb83e-90b7-4a25-9bc0-30700f54bc2a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Karissa Soares', '3/10/2024', 2, '5226110853', '450-872-8350', 'ksoaresgz@zimbio.com', '723a6773-3b06-40ef-9310-c797aa25f2d0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Van Weigh', '3/21/2024', 1, '3236633787', '304-323-9029', 'vweighh0@list-manage.com', '978451ae-8749-4e95-b61f-af9fc50cd75b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosalinda Stemp', '12/21/2023', 1, '6276316127', '299-348-3774', 'rstemph1@feedburner.com', '163dc83f-f5b4-46e2-b395-53c1dd659920');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rozalie Gauld', '1/3/2024', 1, '0045840280', '608-912-2507', 'rgauldh2@mac.com', '18805d78-afb2-474d-a13c-8f8e6891dae4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Delmore Whittlesee', '1/17/2024', 2, '2687325270', '437-338-7274', 'dwhittleseeh3@cam.ac.uk', 'f93efcd8-0d5b-44a0-957f-12d85e6793d0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Josee Scotchmoor', '10/30/2024', 3, '6912925274', '894-762-0271', 'jscotchmoorh4@jimdo.com', '9be078b4-a563-4ec8-a820-8882cd3415d9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Blancha Playford', '5/4/2024', 1, '2284449907', '974-787-9333', 'bplayfordh5@foxnews.com', '2c930353-2487-46cc-860d-3b9a848c0e8f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Spense Lunge', '3/15/2024', 3, '0558982513', '747-898-4351', 'slungeh6@japanpost.jp', '0434e965-7d76-4c99-977e-5c7f7675bba9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chickie Martyntsev', '9/15/2024', 3, '5456869234', '169-697-6407', 'cmartyntsevh7@nydailynews.com', '92891ccc-d9e5-4f70-8265-96246214627c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fae Berrey', '1/4/2024', 1, '1679686510', '253-607-5809', 'fberreyh8@berkeley.edu', 'c90a7548-0d22-4275-9498-79994e600ad2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lucias Goldston', '1/24/2024', 1, '6215056178', '446-567-3867', 'lgoldstonh9@yellowbook.com', '596fb0fd-dd28-4268-a08d-2e2d94e2d555');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adrianne_check Raymont', '5/12/2024', 2, '8522382806', '465-504-9935', 'araymontha@un.org', '46fec9d0-3e31-4392-a51f-44db01e333fe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katya Spileman', '1/15/2024', 3, '8773469259', '512-123-4922', 'kspilemanhb@yellowbook.com', '46c3d0a3-cd65-481e-8cc8-e21c7b16adef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Biddy Lowers', '6/24/2024', 1, '2112550729', '932-558-2456', 'blowershc@vkontakte.ru', '49ac5176-3355-46a7-a8de-8c369e3e4f8f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gustaf Malster', '11/23/2023', 1, '5537722829', '513-383-6850', 'gmalsterhd@symantec.com', 'cfbebf0c-781f-40b0-9d80-879a273fa711');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Raymund_check_check Lorraway', '9/25/2024', 3, '8459835529', '376-768-3294', 'rlorrawayhe@ft.com', 'b0016d2e-98e1-4944-bdae-f823e59fe92a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Duncan Grishakov', '9/21/2024', 1, '3338962032', '936-430-8814', 'dgrishakovhf@behance.net', 'de538d6b-f23e-412f-bc8e-f41ffa51aba5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Marilyn_check Rowth', '8/8/2024', 1, '2651285243', '186-554-2187', 'mrowthhg@liveinternet.ru', '716087ea-0319-4bc3-97be-8a8664b409d7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Terri McCuffie', '10/13/2024', 2, '8171780411', '519-775-6038', 'tmccuffiehh@illinois.edu', 'fef2104b-7803-4f6e-b3bd-c15e96745102');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Creight Sherbourne', '3/8/2024', 1, '7429642658', '685-141-9775', 'csherbournehi@usatoday.com', '456e4d6d-aa42-41bf-b878-5926b613b3de');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Zebulon Martynov', '7/24/2024', 1, '2422675721', '138-614-2759', 'zmartynovhj@instagram.com', 'd6fc2736-23a3-4f19-b0c4-68b4ff458b14');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Georgeanne Lansly', '6/8/2024', 1, '7537943587', '732-340-2189', 'glanslyhk@google.nl', '1400942d-9e25-4aa4-954e-fc10e9c545cb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jessee Frampton', '1/24/2024', 1, '4904625717', '679-799-5862', 'jframptonhl@arizona.edu', 'fe383269-6c34-400c-a83c-ba9aa5ba3312');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ignazio Stienton', '9/23/2024', 1, '0735696200', '961-262-1052', 'istientonhm@huffingtonpost.com', 'a4d35793-2215-4d88-adea-1cf52e694624');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vernor Van Arsdale', '10/16/2024', 3, '9084379895', '515-877-8194', 'vvanhn@addtoany.com', 'c15c9b1b-c55c-45f1-8077-e4ef75c7459c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elmo Mineghelli', '4/5/2024', 2, '3365646660', '103-625-3826', 'emineghelliho@multiply.com', '233926da-3b38-40ef-97df-d38de9009b54');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ibby Boggas', '1/21/2024', 1, '2341949773', '659-124-4678', 'iboggashp@toplist.cz', 'd148e034-a755-4fc1-a0f9-29d4f5d95c97');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kingsley Mose', '2/24/2024', 2, '1939265729', '550-473-4359', 'kmosehq@goodreads.com', '3af82c1a-6a69-405f-9ed8-dcca6cf72d19');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Axel_check_check De Biaggi', '12/5/2023', 3, '0489130534', '699-857-4005', 'adehr@ameblo.jp', 'b1e6af81-f0ba-425e-b544-45e15ba99b7f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nanny Whiteford', '4/7/2024', 2, '9191397642', '797-287-8314', 'nwhitefordhs@telegraph.co.uk', 'fb7eb080-5811-417d-a159-d4938c4a01bf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kingsly Jasper', '1/24/2024', 1, '2353147732', '343-881-2110', 'kjasperht@cmu.edu', 'ae30425c-4c32-49a5-acca-b03b9901e235');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ange Banstead', '10/2/2024', 1, '3765680759', '193-971-2406', 'abansteadhu@google.fr', '4c1e2580-4b4a-46c5-ad9d-0509b7ff9776');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Allissa_check Fendlow', '9/22/2024', 1, '9561804594', '828-805-7010', 'afendlowhv@businessweek.com', '2b104055-71e8-47fd-a006-eeafaed73baf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tanney Walder', '5/18/2024', 2, '4379085097', '848-840-7112', 'twalderhw@unblog.fr', '3daf5e07-4281-44dc-a983-fa02856de4da');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cecilia_check Drieu', '9/22/2024', 3, '1085849536', '402-384-1209', 'cdrieuhx@china.com.cn', '52f8b027-5389-4c3c-bb7f-c02d956092d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Diandra Buttrum', '4/17/2024', 1, '4532100685', '408-220-3034', 'dbuttrumhy@fc2.com', '1fc940b1-cb96-49b2-b580-65cfb0c08b01');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Farr Jewster', '12/13/2023', 3, '8566850194', '512-112-0304', 'fjewsterhz@ucoz.com', '32dd46a4-d5c2-4c6d-9e13-e5e3c20f5966');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Valeria Levecque', '4/28/2024', 1, '3569432385', '287-613-7360', 'vlevecquei0@yale.edu', 'fb8d853b-5f5e-431e-b614-33a7f3b82e63');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Christopher Hinder', '9/30/2024', 2, '3782781632', '757-616-3997', 'chinderi1@barnesandnoble.com', 'f4254c94-42f2-40cd-aff9-30144d0cdb7f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darell Trytsman', '7/24/2024', 3, '4135425612', '134-489-2144', 'dtrytsmani2@hhs.gov', '0d6d4c55-33ac-46c9-abd1-f52640f2a940');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Petronille Showell', '4/8/2024', 2, '8981977892', '261-284-7680', 'pshowelli3@acquirethisname.com', '9565cac6-7d27-4f22-b742-aee65ea4b249');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Loydie Raithmill', '2/19/2024', 1, '4237575486', '443-196-0792', 'lraithmilli4@cbsnews.com', 'fb71ab55-9b1a-423b-af2b-07d22fd4b6ef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Allan Braizier', '7/21/2024', 1, '3076148846', '927-530-9321', 'abraizieri5@slate.com', '24fe102e-b0cd-45e4-90cd-f3615e854635');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kayla Priter', '11/5/2024', 2, '3770485294', '830-624-4553', 'kpriteri6@telegraph.co.uk', '39ac18dd-6bcd-485b-8c2c-ed8227464a32');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ali Tomaskov', '9/12/2024', 3, '2543866244', '770-743-1643', 'atomaskovi7@gmpg.org', 'd82102bc-4eb1-421d-ad5c-9038515a7ec9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nonah Waith', '12/13/2023', 3, '5372707433', '875-597-6720', 'nwaithi8@ning.com', '6e85e427-f76d-4dcc-9bb2-4b0494f9dd13');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katya Coppeard', '11/22/2023', 1, '0980679204', '960-568-3070', 'kcoppeardi9@mashable.com', 'd93ac300-9731-40c4-94a6-63c64ed810c7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andy McGinley', '11/18/2023', 3, '5777549765', '213-171-9208', 'amcginleyia@gravatar.com', 'a78dabf2-19b7-4200-9a91-50a95aeab575');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thaxter Maltster', '2/7/2024', 3, '2255030980', '772-114-5425', 'tmaltsterib@weibo.com', '15487ac8-6bce-4b77-a024-9651a3b02414');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gene Herculson', '8/13/2024', 2, '4850408580', '580-242-8177', 'gherculsonic@indiegogo.com', '9c587cee-bbf4-4f32-875c-fa0cea605eba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Melessa Trinbey', '4/25/2024', 2, '4258843602', '208-657-1760', 'mtrinbeyid@feedburner.com', 'a6ed8cfa-65ec-4030-9d57-b36092e5c00b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Abrahan Doles', '3/10/2024', 3, '7194227284', '865-782-0068', 'adolesie@vinaora.com', 'f1d1b239-bfd3-4dac-8d67-245b20540b4e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Talya Burlay', '7/19/2024', 2, '4594754338', '524-415-6585', 'tburlayif@uiuc.edu', '7551016e-454f-478e-9cea-27bd42b53b7f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nadeen Rodinger', '12/27/2023', 1, '1510418239', '146-476-4915', 'nrodingerig@netlog.com', 'fbb6477a-6980-4822-9247-145dd6e0655d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tobias McRamsey', '10/31/2024', 1, '2475991337', '771-790-8872', 'tmcramseyih@vistaprint.com', 'a970884f-5908-43e2-bc2e-de35818bd708');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guglielma Vorley', '3/9/2024', 1, '7863592537', '336-227-1009', 'gvorleyii@unblog.fr', 'a4be0f87-a6e9-47c7-8878-2167028809da');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ximenez Mandal', '8/28/2024', 3, '2573795981', '623-146-7355', 'xmandalij@nifty.com', '49063ec1-b943-4c4f-b836-bdb63b571043');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carmela_check Cella', '3/31/2024', 3, '9576597220', '900-120-0516', 'ccellaik@craigslist.org', 'bb28ec9e-6a52-44bc-b44f-f53778a58a62');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emmalynn Attwoull', '8/6/2024', 1, '7161751172', '427-363-7078', 'eattwoullil@goo.ne.jp', '76200995-dfdb-486e-b8df-539e2031fbba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tymothy Heymes', '5/25/2024', 1, '2330183804', '452-561-4034', 'theymesim@fda.gov', '03763c93-7d4a-4217-9e20-657358f839bf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tabby Diemer', '7/16/2024', 2, '3003027916', '943-682-6702', 'tdiemerin@exblog.jp', 'f23e3eb9-e2df-42f9-b25f-401f1372495d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Morgun Alfonsetto', '11/25/2023', 3, '5239903450', '836-659-3028', 'malfonsettoio@mozilla.com', '766a1bf0-9e1f-4deb-8c93-4753794c7ed8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Faye Kindall', '8/25/2024', 2, '3649506215', '574-961-7034', 'fkindallip@edublogs.org', 'd2112caf-68d0-4e2e-bf96-9801ebe1a3b2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dominique Holdall', '7/4/2024', 3, '9335613852', '969-769-2112', 'dholdalliq@posterous.com', '1727805a-c1b4-4f38-a6ca-a24d9a6cd27e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Egor Armour', '12/28/2023', 1, '4114009669', '395-114-9462', 'earmourir@hc360.com', 'caa75089-cdf4-4fd5-af84-60f86c7a7293');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eilis_check Jerrams', '6/1/2024', 3, '7574289420', '886-560-2820', 'ejerramsis@hibu.com', '04358dc4-34c2-482f-ae94-67cbcffe38dc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Erminia Desquesnes', '2/11/2024', 3, '0677675954', '523-215-6057', 'edesquesnesit@accuweather.com', '43052229-fb28-41d9-9a97-b09ba0b6148a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Koo Salmons', '1/24/2024', 3, '7863407409', '869-139-4297', 'ksalmonsiu@soundcloud.com', '8e0381df-65d7-4f7e-8c83-460649a8e2fa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Traver Lamasna', '10/10/2024', 2, '0848256089', '795-665-7599', 'tlamasnaiv@yahoo.com', '798fb06d-c664-4821-b573-e857d500087b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lindy Given', '1/25/2024', 1, '7409174072', '373-863-6424', 'lgiveniw@who.int', '8414a2e4-4423-4a67-9fab-e94d75046a19');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Frederik_check Gomm', '2/23/2024', 2, '3894604920', '415-524-9167', 'fgommix@furl.net', 'ac32931e-0425-4a43-8c71-6ffc622072fc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Missie_check Shemmin', '2/9/2024', 2, '5130380329', '773-473-1860', 'mshemminiy@sciencedirect.com', 'f42bc7c7-7502-4077-badf-aa2b6027d1ff');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jolee McGowran', '2/10/2024', 2, '7745126162', '448-234-7336', 'jmcgowraniz@skype.com', 'a7877f3d-9bf1-4bf9-8b68-786f700a1fba');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kendrick Menpes', '12/21/2023', 2, '9444792746', '905-659-7588', 'kmenpesj0@go.com', 'fd3f492f-f749-4d4e-b740-c845e7412820');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mohammed Geraghty', '7/27/2024', 3, '3069946806', '456-944-5966', 'mgeraghtyj1@1688.com', 'd358306e-da50-46b3-8f79-5e7326298b08');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jillene Lannon', '10/5/2024', 3, '6012987351', '323-644-5856', 'jlannonj2@wikipedia.org', 'bfde2a53-3f21-413b-b911-f04d3ad7d71c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salomone Wise', '2/26/2024', 1, '1986964445', '653-301-9370', 'swisej3@wordpress.com', '8b1bcb05-cfc8-401f-b759-2e6811f8bcca');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Berty Ravenhill', '7/7/2024', 2, '8333486796', '503-966-2356', 'bravenhillj4@dailymail.co.uk', '4dbc6e4d-04cd-453b-814b-1b4804cb1740');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Zara Mirfin', '7/25/2024', 3, '2255697418', '554-191-6805', 'zmirfinj5@jigsy.com', '971f6769-529d-4737-a9dc-162669e8a4c6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arly Norcliff', '2/29/2024', 1, '2474417685', '142-709-4421', 'anorcliffj6@epa.gov', '5c54a63f-2317-4721-8ca9-c9ae78059f6b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arnuad McCard', '12/6/2023', 3, '1906793222', '233-924-6470', 'amccardj7@blog.com', '025a0948-bc90-4c08-a2fe-8cd18e4226cc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sidonia Cassel', '10/28/2024', 2, '2818900051', '333-869-1447', 'scasselj8@prweb.com', 'cec4a27b-663d-4f4e-a9c0-6a9a794eb148');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wittie Farmery', '8/30/2024', 2, '6439808301', '515-352-8084', 'wfarmeryj9@narod.ru', 'beae7fd1-a31c-4f0f-b67c-8530a1171c40');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fons_check Bazire', '9/6/2024', 1, '7069888488', '455-942-8520', 'fbazireja@tinyurl.com', '0b55caad-e7c1-4e66-8bf7-758520d3ed2f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Natty Maren', '11/4/2024', 2, '7290834198', '804-874-6741', 'nmarenjb@a8.net', '19a8bcb3-380a-426b-ba51-082545b782a2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Maude Matussevich', '8/14/2024', 2, '4544017275', '966-725-2564', 'mmatussevichjc@e-recht24.de', '747733d8-b10b-4169-a24a-52400b2c8ac2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emlynne Tonnesen', '8/24/2024', 2, '5853459646', '580-419-3022', 'etonnesenjd@facebook.com', 'e42876f6-a0d2-417b-9e33-29363b456baa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lorne Rosenzveig', '2/25/2024', 2, '8215972290', '661-142-2389', 'lrosenzveigje@utexas.edu', '24a08e15-c112-4776-8de2-df2b47095140');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Janna Pumfrey', '6/24/2024', 3, '8258390666', '969-107-8656', 'jpumfreyjf@go.com', 'ab50c130-366b-43ea-99bf-759d59d85d42');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thia Sherston', '1/30/2024', 3, '6936591922', '474-732-0799', 'tsherstonjg@ask.com', 'db84bde3-105d-4f48-a24e-8ed93cf7ccc1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Toma_check Amey', '3/18/2024', 1, '0757173376', '908-804-0002', 'tameyjh@xrea.com', '97cec8ef-04dd-4788-872e-92400c54a9a3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Thomasine Kenaway', '5/24/2024', 1, '0861178336', '778-993-9001', 'tkenawayji@timesonline.co.uk', 'ef15423f-dffe-4ae3-bca9-38d081d5cb96');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barry Gorgler', '7/4/2024', 2, '0288617741', '483-829-4452', 'bgorglerjj@live.com', 'ced1362f-0dc3-4ec2-bd1e-5d14a73a1480');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Woodie McBeth', '11/27/2023', 1, '9993022654', '564-885-9968', 'wmcbethjk@blogtalkradio.com', '4b8674a7-ac38-47b5-984e-4d7faefb5477');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leupold Rozzier', '9/29/2024', 2, '2744454333', '945-351-4163', 'lrozzierjl@msn.com', '930e0099-042f-40c4-8c1f-dc2207683b72');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Idalina Darington', '8/11/2024', 3, '8150347823', '582-792-2504', 'idaringtonjm@webeden.co.uk', 'cab1f44b-581b-4adb-a02e-85702a75003e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sanson Meriguet', '12/10/2023', 1, '6229470563', '703-376-5041', 'smeriguetjn@omniture.com', '46940000-143b-4f40-847a-f124378f0689');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kynthia Hamberston', '6/25/2024', 3, '1276885504', '187-920-8290', 'khamberstonjo@ucsd.edu', '30462a02-2e55-4465-a072-42221f5b7e8f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clio Mapam', '9/29/2024', 3, '3791865357', '568-325-0736', 'cmapamjp@ezinearticles.com', 'b44f8cec-1ef7-4287-a738-fbce8241210f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Damara Mobius', '1/20/2024', 3, '7287566134', '384-392-4823', 'dmobiusjq@forbes.com', '76225b44-0ebe-44a3-bce6-8a46f7597652');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alanna Jonathon', '12/5/2023', 1, '4770448651', '403-486-0311', 'ajonathonjr@independent.co.uk', 'bdbf1dd5-f2eb-480c-8f89-3fcfda816ab8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Any Bichard', '8/12/2024', 3, '5531698597', '244-300-3459', 'abichardjs@prnewswire.com', '3c472ee9-1b05-4020-83c9-ac0b63a98d19');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Doralia Kemell', '9/21/2024', 1, '0007371337', '578-760-8727', 'dkemelljt@elegantthemes.com', '296ddf7f-f985-4308-a458-d5ab23544bab');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Buck Gretham', '9/27/2024', 3, '9442897463', '722-602-0230', 'bgrethamju@thetimes.co.uk', '702e25f7-3676-40b8-aad8-ae1a38065673');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katleen Widdop', '9/25/2024', 3, '4098632365', '437-212-3953', 'kwiddopjv@ocn.ne.jp', '4f6c70fa-5cf8-4e7a-96ef-fe6742ba83c3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hilary Bodman', '9/27/2024', 1, '8284148004', '520-954-3423', 'hbodmanjw@google.pl', '2ea0e641-90af-41d0-a99b-24510b1af943');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bearnard Nelane', '3/27/2024', 1, '9524332289', '466-878-5956', 'bnelanejx@google.pl', '00f07011-4ff7-4bb5-845c-1f3a863e55f9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gayle Conti', '6/22/2024', 1, '1298145247', '223-840-0191', 'gcontijy@domainmarket.com', 'd207ee52-368a-4ea0-a60e-8831513ab52f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Camilla Gask', '1/4/2024', 1, '9484336150', '916-739-3860', 'cgaskjz@xrea.com', 'add6c199-3a64-4842-8bc6-ccab0b89295c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rey Bozworth', '2/12/2024', 1, '7118946042', '725-566-1764', 'rbozworthk0@blogs.com', '148a109b-d86e-49de-8ccb-df6781251406');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Phebe Winsor', '10/7/2024', 1, '9652585870', '154-158-8741', 'pwinsork1@amazon.co.jp', '43544b75-86ac-4a3b-9cd7-7973aeb0508b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kimball Moiser', '7/7/2024', 2, '7508156353', '650-626-4378', 'kmoiserk2@hugedomains.com', '634c2590-a17c-471e-a254-9a576343e793');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eduard Cartmale', '11/8/2024', 3, '0872642299', '202-280-1386', 'ecartmalek3@amazon.co.uk', 'ad6c898a-347a-4b52-b452-7cf2a3137d9b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wylie Garza', '10/5/2024', 3, '3102109995', '482-407-0130', 'wgarzak4@artisteer.com', '85dfcd12-6a97-463b-9b24-6e32679fd5a8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Erroll_check Lydon', '10/4/2024', 2, '3200079656', '953-267-7038', 'elydonk5@biblegateway.com', '562d8dd9-7fc3-47da-9047-f09fd410d4fc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jesse Blinde', '4/15/2024', 2, '6334918920', '458-540-5384', 'jblindek6@squarespace.com', 'b23c1b8d-0698-48c3-b951-0c4dc542fedb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aloisia Spick', '4/12/2024', 3, '0846075513', '434-381-2873', 'aspickk7@nhs.uk', '0203b029-d338-448c-ae80-eaf6fd8c91b0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rorke Yatman', '10/16/2024', 3, '1256738191', '780-384-9188', 'ryatmank8@drupal.org', '2d85650d-d617-4042-a800-ba691301cf37');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Felicle Meiklejohn', '10/27/2024', 2, '1112788572', '645-812-6244', 'fmeiklejohnk9@time.com', 'e93f56b3-ff4b-4a0e-b576-ce81ea7b8da4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Viviene Elliff', '8/8/2024', 1, '0119191835', '182-552-9033', 'velliffka@virginia.edu', '8b806317-48d6-4c9f-814d-09cd2a7d4d4a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Debee Raiston', '10/30/2024', 3, '9539740113', '676-705-4055', 'draistonkb@slideshare.net', '745b0c27-14ae-4420-8e31-2672c93c97cc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Silvio Gilffilland', '1/15/2024', 1, '6222964813', '877-898-8277', 'sgilffillandkc@fc2.com', '500e42e1-591d-4c7e-911f-89987eee9e05');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Michelina Cathersides', '1/8/2024', 2, '0948129802', '392-273-8404', 'mcathersideskd@shareasale.com', 'f4c5b404-8c80-4646-8e8f-0a60b4d08879');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hillie_check Brydie', '8/1/2024', 2, '6363703681', '866-616-2256', 'hbrydieke@princeton.edu', '86c6fc0c-c727-4aee-8269-ee8cce6e0580');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cleopatra McManus', '11/19/2023', 2, '5298130553', '998-603-0546', 'cmcmanuskf@posterous.com', '5a556473-fd90-4328-90a9-641806b6c663');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Oswald Bangiard', '8/3/2024', 2, '3109188100', '624-235-9542', 'obangiardkg@rambler.ru', 'cd3861df-e2a3-4cb5-b6f2-bc312d55e8d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Evan Dibble', '1/21/2024', 2, '4009194229', '717-237-7783', 'edibblekh@ehow.com', 'fdcd4e76-378f-4e4a-b88b-c377fab88460');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kalil Klaffs', '3/27/2024', 1, '5286853615', '880-533-9164', 'kklaffski@freewebs.com', '00f99fcf-7a49-45fc-96ba-2b849e6283f7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Othella Dedrick', '7/10/2024', 1, '8258717049', '718-260-8339', 'odedrickkj@ycombinator.com', '01ca3164-e55b-460c-bb01-d03cde260a68');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cammi Alkins', '2/5/2024', 3, '7417383855', '410-210-4826', 'calkinskk@telegraph.co.uk', '4a69ae88-ac66-477e-86f0-7dc5247203e6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hildagarde Cutridge', '9/7/2024', 3, '2843592728', '112-667-1429', 'hcutridgekl@biblegateway.com', '282c3419-2d30-44e8-9c93-57caa6d85276');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nerissa Verman', '10/3/2024', 3, '4108400314', '850-712-1965', 'nvermankm@slideshare.net', '2e82ee31-e7ab-4f1d-980f-94245f2992c0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lesley Vurley', '5/18/2024', 3, '9298510017', '892-305-1374', 'lvurleykn@nbcnews.com', '96a7ab05-fa57-4d6a-b951-baca97c2992e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hallsy_check Duinbleton', '4/28/2024', 3, '0986359641', '574-971-9605', 'hduinbletonko@youtu.be', 'd734f685-98ea-45c0-829e-5869a9b97765');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fiorenze McGeouch', '7/11/2024', 1, '5209700017', '393-888-7485', 'fmcgeouchkp@cargocollective.com', '8498bc06-b057-4b50-b219-ef53da5c2575');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lezlie Austen', '5/31/2024', 1, '3180251682', '615-583-2662', 'laustenkq@skyrock.com', '492858a1-8818-4157-a3c1-341a49c9659b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Veronike Collyns', '6/24/2024', 2, '3788271820', '411-958-0405', 'vcollynskr@google.it', '386a0aee-b4a2-4bd3-8ed8-a1f97a6e6700');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Edvard Norley', '9/3/2024', 2, '5568371907', '593-440-0433', 'enorleyks@51.la', '5c8c662b-9baa-456d-b45b-13eb359731dc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elysee Hub', '3/14/2024', 3, '7852107851', '615-315-2182', 'ehubkt@weebly.com', '29de807f-0c9c-4d29-86e8-8b54ec6f82d6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ramona Cavolini', '3/18/2024', 1, '6837117836', '256-137-3389', 'rcavoliniku@is.gd', 'b2475ed4-c515-46bc-81f8-2491fa524e74');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nathanael Adlam', '4/21/2024', 3, '7869169276', '532-750-3204', 'nadlamkv@github.com', '595f5190-bebc-43ec-8e99-ccd15ec8cc03');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kellina Watson-Brown', '10/15/2024', 2, '0350477983', '212-308-8606', 'kwatsonbrownkw@ezinearticles.com', 'f1241ac0-4786-418e-bda5-53aff15e809a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Deeann Firbanks', '8/30/2024', 3, '9355263128', '188-962-4518', 'dfirbankskx@nymag.com', 'd1168831-cb8f-419a-9fd2-18b19d9e9e60');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Miguela Ballin', '11/18/2023', 2, '6273277354', '422-143-3506', 'mballinky@wisc.edu', '2a164aea-f7f2-4745-acdf-dcdb72d879bf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Murdoch Buret', '10/24/2024', 2, '2288829323', '541-535-8740', 'mburetkz@telegraph.co.uk', '1623f562-9545-4bef-9520-30d5262676cb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hillary Chanter', '9/17/2024', 3, '6433269392', '269-203-8180', 'hchanterl0@dot.gov', '2986e3be-3fff-429a-a55c-7f4ccdb8ee0c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mitchael Knappe', '8/29/2024', 1, '6776924610', '530-846-3420', 'mknappel1@ox.ac.uk', '31a5eb4e-d806-4b44-a6fe-7dcd60f3f3d6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kent Tattersdill', '8/11/2024', 3, '2730119134', '374-354-6987', 'ktattersdilll2@opera.com', '67829bf6-3402-4d5f-85f6-aa0a6493ec4a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Georgie Presswell', '10/10/2024', 2, '5418946093', '460-116-5153', 'gpresswelll3@slideshare.net', '0e32a5c0-807f-4bdb-a79c-9ccb32bc4e15');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shea Jiggens', '12/28/2023', 2, '8628483307', '351-706-7557', 'sjiggensl4@cbc.ca', 'b9143131-e642-4c4d-a4af-08a1a363c83b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shirlee Mussalli', '10/14/2024', 2, '9513733890', '119-459-1052', 'smussallil5@issuu.com', 'd10dbd67-e8dd-4c52-ad42-39511f4fde3e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tanney Sterzaker', '6/29/2024', 1, '0392639083', '210-437-0590', 'tsterzakerl6@wufoo.com', '7e0528ec-bd55-4de7-a1f2-52393fcb1464');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Daveta Dallimore', '2/3/2024', 3, '1516575082', '663-756-0390', 'ddallimorel7@ucoz.ru', 'fae3aa76-a738-4b8a-b9cd-5e8b9be7aabd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carmelina_check Oppery', '4/3/2024', 3, '4930429133', '608-287-9518', 'copperyl8@nifty.com', '1e576a92-af9f-49a3-9962-75a06fe175ac');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jared Swanne', '12/31/2023', 2, '6278384205', '355-316-2175', 'jswannel9@jigsy.com', 'ee9e38e5-024e-48b0-a7bd-1a56979b08bb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ainslee Drugan', '3/9/2024', 3, '6074804401', '425-538-6721', 'adruganla@netlog.com', 'c88becf2-653a-4ff8-9e03-033e579268cc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ragnar Bircher', '9/7/2024', 1, '7494513672', '735-400-4912', 'rbircherlb@va.gov', 'bf82df6d-b168-4f76-be00-9969ecbde4d2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bruno Oldale', '6/28/2024', 2, '4532523483', '281-295-6718', 'boldalelc@addtoany.com', 'f4d42ea8-3632-480a-b2d7-7f4dfbbe750e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Efrem Seide', '10/20/2024', 1, '9481523155', '129-930-1677', 'eseideld@edublogs.org', '2ffb3cab-ec17-4e65-8d75-7ff7190e4e14');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nert Grayer', '5/19/2024', 3, '6986147530', '317-229-3324', 'ngrayerle@angelfire.com', 'a0891b52-c14c-4579-8008-8bc7bbb2b3af');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jennica O''Hagerty', '11/10/2024', 2, '8067426908', '108-569-9824', 'johagertylf@cnn.com', '948133d1-e1a3-464f-bf9c-bbafb3f6de5a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arch Swalteridge', '7/27/2024', 3, '4921287891', '479-654-1520', 'aswalteridgelg@about.com', '9f3c1145-9556-4ae2-976e-006f010232fe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vilhelmina Rittelmeyer', '5/8/2024', 1, '4610153524', '408-148-7024', 'vrittelmeyerlh@oracle.com', '66f8df46-f92b-4a4c-bddf-47a08d231f60');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jakie Cowely', '8/8/2024', 1, '9159700713', '780-835-4277', 'jcowelyli@dmoz.org', '833e98fc-bd59-4a3b-9578-6d101c453c33');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Floria O''Hannay', '3/22/2024', 2, '1331574055', '440-225-7291', 'fohannaylj@seesaa.net', 'caed5870-75a0-403f-8ad9-ffeb392f9547');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rainer Thornbarrow', '6/15/2024', 1, '6139611225', '761-693-1938', 'rthornbarrowlk@hostgator.com', '1fcbfe87-2217-4509-b77f-c12b789c5857');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chantalle Lockney', '12/9/2023', 1, '0245884139', '580-361-0294', 'clockneyll@instagram.com', '7cd403a2-dbac-455b-90a1-7150ee59bdf0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gratiana Marte', '7/20/2024', 2, '1075225368', '953-240-8497', 'gmartelm@squarespace.com', '29ccc742-ced7-4499-ad15-9fd6ea72aa26');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Carilyn McQuaker', '6/29/2024', 2, '2675605355', '910-657-0420', 'cmcquakerln@fotki.com', '9aa1f333-27da-4dbf-926f-a6390767f8e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emmie Silson', '6/21/2024', 3, '1498800340', '312-510-1928', 'esilsonlo@bluehost.com', 'b88a299c-0a5f-4070-b52f-2082a377a20b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Marlie Renner', '9/14/2024', 1, '5777628457', '587-442-9575', 'mrennerlp@ed.gov', '1a858ef6-4390-49a1-81bb-655d8b9b2a86');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Judd De Fries', '7/19/2024', 1, '0200237295', '437-833-5426', 'jdelq@scientificamerican.com', 'f73e8ad7-3f34-45c0-a334-15aebcbca6a6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emerson Rackam', '5/23/2024', 1, '9288354822', '609-628-6286', 'erackamlr@hugedomains.com', 'd2aa25b1-325f-4bb0-8cbe-5e007e2af2ca');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barby Martinovsky', '3/24/2024', 2, '9527465689', '614-202-9630', 'bmartinovskyls@51.la', '5d78d7cd-c707-4e23-a553-2b56a198e2be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Berkie Mayoh', '7/9/2024', 1, '7687474137', '371-989-9820', 'bmayohlt@berkeley.edu', '82c363df-55d7-4b51-bb69-3124d08ec749');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salli Jori', '6/26/2024', 3, '0130544517', '771-526-0362', 'sjorilu@marketwatch.com', 'c451e84c-2d07-4a72-b083-c4f35ef51c68');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Walsh Coolahan', '6/5/2024', 2, '2767212672', '980-121-9314', 'wcoolahanlv@nydailynews.com', '73095ccc-58a1-4549-a157-d2e1b8d7f8e2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Winfred_check Huzzay', '5/5/2024', 3, '0168042277', '698-752-0650', 'whuzzaylw@bloglines.com', '7aa808d5-cc50-4ebf-bf6d-e1dfb6afbbda');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Colly Cockerill', '8/17/2024', 3, '7730304834', '787-645-9915', 'ccockerilllx@nydailynews.com', 'e99d893a-9d72-45b8-89d2-8bf89f95b16e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rhett Sedman', '4/15/2024', 3, '1299564291', '324-957-0257', 'rsedmanly@vkontakte.ru', '01b7b4b5-1e12-4d2c-ad60-ed7c59a8f963');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Humfrey Fairchild', '6/30/2024', 2, '6100325359', '807-228-7810', 'hfairchildlz@usnews.com', 'b0736b39-fe25-42ef-a645-d266ef797a8b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alyosha_check Kimbling', '3/6/2024', 3, '1241679546', '841-469-8130', 'akimblingm0@biblegateway.com', '7528423e-e077-4ea8-b547-9d64e8022242');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Delmer_check Byham', '5/20/2024', 3, '8140736268', '742-612-1177', 'dbyhamm1@wired.com', '72adf228-264a-443c-9f6c-c84fc2b830e5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosemonde MacAskill', '10/22/2024', 3, '6670914501', '533-545-6197', 'rmacaskillm2@ebay.co.uk', '8ae3251c-129a-4e40-bf53-a1155ee90faa');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Armin_check Fawley', '2/7/2024', 3, '2991734323', '191-629-1319', 'afawleym3@yandex.ru', 'bb06e60e-0fb8-4714-93ea-a63b0d87e49c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jordanna Heard', '8/23/2024', 3, '9008794272', '980-324-3686', 'jheardm4@nhs.uk', '4000472b-1bb0-4e85-a3be-e791e55dc4f9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Patricio Treker', '3/4/2024', 1, '4192431543', '436-663-3088', 'ptrekerm5@fda.gov', '5e0cdf57-1772-4534-aaf8-16d3b48c5509');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Anderson Clyant', '9/4/2024', 2, '8418070436', '980-339-5633', 'aclyantm6@youtu.be', '8065cc58-8fc2-4207-846e-3cf59fb274b5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Quinton Bresner', '4/16/2024', 2, '0301020748', '763-351-8254', 'qbresnerm7@statcounter.com', '5de906b8-7ed4-41b8-962b-1ed5360bc2bc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Katharyn Alldred', '1/14/2024', 2, '6332343193', '925-904-1143', 'kalldredm8@oracle.com', 'e4b52804-4ab6-43fe-8d13-38517226ad8c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Harriette Baudinot', '8/22/2024', 1, '7855128980', '818-211-0543', 'hbaudinotm9@marketwatch.com', '5e97475c-f9f0-46ed-8bfb-c2fcb646536f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Amalie_check Rainger', '8/11/2024', 2, '4566605219', '455-799-5817', 'araingerma@uol.com.br', '0365a35d-6e2c-4dba-a585-2562af407b71');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lexis Purves', '7/8/2024', 3, '4602648973', '945-880-8656', 'lpurvesmb@about.com', '829b73a0-bc28-41c8-9b63-f9bc2d3be13d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dalton Gumly', '10/20/2024', 3, '7255255495', '171-561-5073', 'dgumlymc@last.fm', 'a8de301f-16cc-4931-8cad-dcb131f3cb3f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ynez Fresson', '12/21/2023', 3, '6788550572', '637-714-4980', 'yfressonmd@bandcamp.com', '11e30412-4e13-4c38-a47c-90c0ed41138f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dannye Aubury', '10/6/2024', 1, '8024888883', '306-832-5513', 'dauburyme@free.fr', 'add4d5f1-eb18-4cd2-9233-199ea59c132e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Novelia Heintze', '8/14/2024', 2, '0774796555', '989-645-0603', 'nheintzemf@stumbleupon.com', '67d16270-98c4-434b-a3b4-82aaecf8e5f6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rosco Yewdell', '9/1/2024', 3, '6032522880', '831-301-8065', 'ryewdellmg@eepurl.com', 'b8792ab4-42e3-4674-8bd5-d27ca13e7f95');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Inesita Drinan', '4/16/2024', 1, '9199311208', '464-735-5592', 'idrinanmh@amazon.de', 'b8bbc16e-b052-4251-a348-881abd0e9f02');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ilse Roony', '9/14/2024', 3, '9477125465', '191-499-0532', 'iroonymi@privacy.gov.au', '04f4b172-7621-42d0-8868-693f1e73f889');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ag_check Taggart', '8/14/2024', 1, '9901652606', '917-354-7119', 'ataggartmj@youtube.com', 'af2653ae-e81f-4df7-988c-f75a02aed45b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brandy Cobden', '10/15/2024', 2, '7917132940', '345-409-2087', 'bcobdenmk@google.com.hk', '2bd710fc-df75-4259-a799-e2cf71e5820d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Phineas Volkes', '10/7/2024', 1, '5189713311', '709-455-5232', 'pvolkesml@woothemes.com', 'ee71b497-296a-4e82-a1d7-3edcd4836a20');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lonee_check Caustick', '9/19/2024', 1, '4673924486', '551-291-1023', 'lcaustickmm@dell.com', 'edda1156-c190-4f16-87fd-4701a4e7ece3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sanson Ingerman', '5/14/2024', 2, '0971869067', '113-609-6719', 'singermanmn@slashdot.org', '48c32822-4f88-4c91-999b-91762d044b5e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Micky Arnason', '2/15/2024', 2, '6038349901', '780-843-2686', 'marnasonmo@about.com', 'ce701bb8-61f1-4612-86c9-f4e04598a553');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eveleen Menpes', '9/7/2024', 2, '4916513378', '437-667-3820', 'emenpesmp@skyrock.com', 'cadb988b-4fb5-4064-b161-b7ec39d0a446');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brinna Boner', '9/4/2024', 3, '0365638927', '842-838-1534', 'bbonermq@oaic.gov.au', '7b438f2f-cbce-4cc4-aff0-cfa43af4ee65');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Roselin Slimmon', '9/26/2024', 3, '0525960191', '455-273-8712', 'rslimmonmr@usda.gov', 'd4c6c1e2-f2b6-458f-800f-c55eb4f537dd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tasha Petrushkevich', '9/24/2024', 2, '9718752899', '962-447-5687', 'tpetrushkevichms@miitbeian.gov.cn', '3add7cae-8571-4cc4-94ae-242eba92dad4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andra Del Castello', '9/25/2024', 2, '7534754283', '764-336-5941', 'adelmt@epa.gov', 'cc718da9-8666-4f6c-84b6-ffc1c8d1de1d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shannen Silburn', '9/25/2024', 3, '7229233233', '385-856-7777', 'ssilburnmu@patch.com', '0e129764-850a-4ad5-92e7-e9afe86798e1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Donnie Bagwell', '7/22/2024', 1, '4328808144', '472-618-6261', 'dbagwellmv@bbb.org', '19a1f17c-7f90-445f-90b7-38b111a7806e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Phylis_check Burhouse', '5/14/2024', 2, '3350704455', '941-431-6382', 'pburhousemw@irs.gov', '08e5f023-7835-418c-b9cc-196a95382b42');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bronson Vannar', '3/3/2024', 1, '6225456418', '558-131-0778', 'bvannarmx@irs.gov', '8e2feaa5-fdad-49a7-a703-0ac1028a43c9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Didi Glasscoe', '9/3/2024', 1, '5557078333', '754-390-4284', 'dglasscoemy@cmu.edu', 'd3993492-ef3d-447b-a586-9e625a6f7c38');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Georgeta Duerden', '5/20/2024', 3, '1379799215', '195-887-6600', 'gduerdenmz@ucoz.ru', '1e0b379f-3277-4afb-adda-d36ba4685f58');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Anne-corinne Arnecke', '12/23/2023', 3, '2132668332', '692-288-0485', 'aarnecken0@themeforest.net', '46a1f1e5-86e5-41d8-8732-d96f14db9e26');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Boigie Leggott', '3/25/2024', 1, '7990356170', '621-258-4790', 'bleggottn1@imageshack.us', '04b48f8a-9f51-45f0-9d14-667f1b72b7ab');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Judd Bohlje', '7/30/2024', 2, '1221517563', '187-892-6372', 'jbohljen2@intel.com', '5c1b8a58-bc1e-4a99-bf2b-16b1eb04db73');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lemuel Petronis', '11/19/2023', 1, '1349361354', '733-374-0615', 'lpetronisn3@apple.com', 'a78763cd-7851-410b-a337-bb7fd06cc18f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Deborah Elkin', '8/16/2024', 3, '8948680745', '410-884-3100', 'delkinn4@salon.com', '0f841a94-50c8-42d5-9236-720aa62fab9c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Levey Pidgin', '4/20/2024', 3, '4365516935', '459-872-3573', 'lpidginn5@paypal.com', 'efa57844-c3bb-4775-9c21-f8685e051de6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Christophe Giannoni', '9/13/2024', 1, '3495801017', '564-279-8141', 'cgiannonin6@pinterest.com', '1fd0a07a-fbfb-467c-849b-a5e3653b759d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rene Fairlie', '3/10/2024', 2, '9542387229', '325-673-2664', 'rfairlien7@craigslist.org', '2beb1945-62d6-45f5-b6de-d907fd2cb893');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Neale Pennycuick', '12/6/2023', 2, '5194102740', '553-963-2078', 'npennycuickn8@guardian.co.uk', 'f09ffa3d-ec0d-4dfc-bcf1-998710f64bd2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Yvette Farncombe', '6/13/2024', 2, '8985384026', '140-904-6654', 'yfarncomben9@aboutads.info', '291cb5b7-abbd-45f9-8672-043db22869c0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stefania Salzburg', '12/8/2023', 3, '1514789013', '466-675-9106', 'ssalzburgna@themeforest.net', '7f35043d-6b85-42fb-8b40-0a4374ae77ab');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Melvin Torald', '8/20/2024', 3, '0725880726', '369-723-8980', 'mtoraldnb@seesaa.net', '6e1fdb00-2db2-4c52-b9a0-45b44adabc75');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kennie Dubique', '5/19/2024', 2, '7243551509', '745-995-9114', 'kdubiquenc@simplemachines.org', 'cd0337bb-c25d-462c-a098-d9e2d156c3a1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jillane Salmon', '9/24/2024', 1, '1467373459', '878-819-4885', 'jsalmonnd@ask.com', 'ec263d51-b850-47ee-bd5e-d9423def3790');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Benoite Passion', '1/19/2024', 2, '3279000029', '220-607-5483', 'bpassionne@nsw.gov.au', 'bad19a82-594e-42e0-8afd-0cccef1a880b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Annamaria Roxburch', '5/8/2024', 1, '0647484592', '783-559-0057', 'aroxburchnf@example.com', '2cd537e5-ea63-4cbe-a8b0-0c302b0390be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fielding Dayborne', '8/30/2024', 1, '1437385064', '310-450-0411', 'fdayborneng@bing.com', '8c27344f-287c-42eb-ad20-34076be9057c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Aubert Patriskson', '5/10/2024', 1, '2848896337', '621-967-8103', 'apatrisksonnh@netlog.com', 'f6524bb7-62ae-4166-a614-66e76075c054');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jamil Shemmans', '7/4/2024', 1, '1198859570', '538-621-9077', 'jshemmansni@jalbum.net', 'e0798536-5033-455d-947c-d7cbfc0f8d3b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Simonne Groll', '12/15/2023', 1, '6571514325', '137-493-6881', 'sgrollnj@bbc.co.uk', '8386fbec-c113-46b3-937f-1056a2f1c717');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Emlyn Furlow', '11/28/2023', 3, '7588139751', '679-162-0925', 'efurlownk@boston.com', 'e6465204-b302-4271-8750-3ed58d294c40');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nita Almond', '7/15/2024', 3, '7913825274', '384-347-2388', 'nalmondnl@addthis.com', 'fdd654cc-8cd2-4e98-9a88-3f2fa6991478');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gayel Edgerton', '2/24/2024', 3, '5510603552', '977-776-1463', 'gedgertonnm@slate.com', 'a7089e0f-45c1-479e-b668-0fe6773b681e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Boothe Rickardsson', '9/19/2024', 2, '2989311654', '190-838-5813', 'brickardssonnn@discuz.net', '25a20c0d-4be4-4d23-b967-6a6516ac861d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rick Reis', '5/20/2024', 3, '4853878748', '978-606-1772', 'rreisno@ameblo.jp', 'cfe7f024-f87a-40bf-bc52-28228123e4d6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alonzo Clemson', '7/21/2024', 2, '9627239652', '180-789-4462', 'aclemsonnp@theguardian.com', 'bf83614c-d34d-473b-b3a0-d095b372ceef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Web Bolesma', '7/22/2024', 1, '6241186759', '284-571-9042', 'wbolesmanq@plala.or.jp', 'b2322069-1f6c-4619-a5dd-b6031497c625');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Baudoin Shallcross', '2/4/2024', 1, '8736607374', '306-631-9741', 'bshallcrossnr@networkadvertising.org', '8c79e84e-e663-4b2f-83b2-c1bcc29aae8f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Charissa_check Meynell', '2/19/2024', 2, '3943243265', '252-298-3493', 'cmeynellns@admin.ch', 'b3073c67-ab04-44d7-ba30-3d016c1e0acf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Raf Tomsett', '10/27/2024', 3, '6973798117', '423-296-8467', 'rtomsettnt@walmart.com', 'cd4dd616-a286-4896-a571-74f26477bdd7');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gianna Lermouth', '11/18/2023', 3, '6174518465', '375-843-8845', 'glermouthnu@google.ru', '5d6d71fb-d2ba-4dbc-884a-8883d76b4c00');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Liva Iwaszkiewicz', '4/27/2024', 2, '6305069552', '678-651-7199', 'liwaszkiewicznv@woothemes.com', '6168428c-a797-40ab-a69b-6ccc2c43496d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leshia Byass', '7/21/2024', 1, '5372974578', '646-397-5948', 'lbyassnw@i2i.jp', '94c11ff4-31f2-4bc2-8213-0b1fb5314545');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Damien_check Kryszka', '3/9/2024', 1, '1804848372', '210-977-0876', 'dkryszkanx@usgs.gov', 'c160c274-ea25-4f8a-bbbc-806db875c1af');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Octavius De Ferraris', '2/23/2024', 3, '6882553578', '664-620-2557', 'odeny@ehow.com', '5af7606c-fae1-4ddd-8815-ce9e87953237');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adrea Surman', '10/31/2024', 3, '3233861584', '983-439-6077', 'asurmannz@amazon.co.uk', '06898176-4a48-470f-a645-76a8a29e86a0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vernice Townley', '2/11/2024', 3, '4250164536', '340-165-0874', 'vtownleyo0@quantcast.com', 'cc499bba-175a-4031-abdd-98417fc8fe29');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nanine Cossentine', '12/10/2023', 2, '1281287518', '140-834-7966', 'ncossentineo1@desdev.cn', '23313d18-1140-4edc-8c91-4de46e2a3f06');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Constanta Torresi', '12/25/2023', 3, '2663306826', '577-443-3697', 'ctorresio2@yandex.ru', 'a71b1275-8ac0-40d6-835f-69883645ec8f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Christoffer Doxsey', '3/4/2024', 1, '0391593961', '526-193-0112', 'cdoxseyo3@unesco.org', '8d4bc0d6-a917-447d-9d66-5857fb4f7253');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cathie Fretwell', '10/7/2024', 2, '6331423779', '153-553-8340', 'cfretwello4@youtube.com', '914b0b08-860b-4b02-a619-6489523005a6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Antone Duchan', '11/1/2024', 1, '3966396919', '697-697-9000', 'aduchano5@sitemeter.com', 'cd46924e-d99e-4a26-ac8d-6fa03fdb1136');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Arlen Dansken', '9/7/2024', 1, '7499499973', '621-383-9048', 'adanskeno6@ebay.co.uk', 'e2e36274-b860-4190-8730-c52e241f4097');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Calli McCutcheon', '12/4/2023', 1, '4659893125', '660-354-3789', 'cmccutcheono7@ovh.net', '3ab8e738-acf4-4100-a404-73d477e079fb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Amandy_check Toffel', '12/20/2023', 3, '7901145824', '875-843-5771', 'atoffelo8@geocities.jp', 'f6d87917-9f84-474f-bba3-5ddff6bca955');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Malia Ryhorovich', '6/22/2024', 2, '3576727110', '633-149-4713', 'mryhorovicho9@amazonaws.com', '90ee1d4a-5840-406d-9f58-46ba64f78079');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kira_check_check Blakeborough', '12/19/2023', 1, '9477308979', '532-154-5621', 'kblakeboroughoa@toplist.cz', '56aaa386-f562-47b0-a478-adab2cc14b71');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Abba Tomowicz', '3/14/2024', 1, '1336004998', '208-746-0475', 'atomowiczob@nymag.com', '31be71d0-c7e2-4b8b-acbd-42d3c20d3cf8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Barnie Beteriss', '4/5/2024', 1, '6912306547', '726-723-2568', 'bbeterissoc@cbc.ca', 'aaf94046-af55-4406-b33a-7820cba484cf');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Babbette Trippick', '8/23/2024', 2, '7281505970', '898-473-6841', 'btrippickod@ed.gov', 'e690b9d4-e7f7-45cd-90a3-5e2039cc73e5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brandon Hofler', '2/29/2024', 3, '9623460431', '585-687-6841', 'bhofleroe@macromedia.com', '0f9bae0f-3b72-4749-969a-786e18d60b7e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jennica Dickerline', '6/18/2024', 2, '0119798682', '509-202-4190', 'jdickerlineof@kickstarter.com', 'b2ab52ba-48a7-489f-8ed8-f14fa814cb42');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Izabel Vidyapin', '10/10/2024', 1, '1734486782', '626-641-7470', 'ividyapinog@feedburner.com', 'c79b436f-9c8e-4caa-acaf-30a4804a77ce');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Liuka_check Heeran', '9/29/2024', 3, '3505444483', '571-654-7258', 'lheeranoh@usnews.com', 'c05c2dd0-39f2-4731-86bf-6ad6bcee2c41');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Christin Restorick', '3/9/2024', 1, '9486476058', '856-395-2822', 'crestorickoi@tmall.com', 'ec172f8f-3ea7-4f7b-b960-2e19bff8f04b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Giulietta de Banke', '3/23/2024', 1, '7327742853', '792-375-6826', 'gdeoj@reuters.com', 'ca04b440-59d0-4802-9679-3ca963f44c04');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guillemette Sparke', '3/15/2024', 3, '3569987458', '294-548-3411', 'gsparkeok@live.com', 'd29ddafa-c840-498b-914b-0e3e51d5baa3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Maribelle Wigzell', '5/7/2024', 3, '6315681073', '723-661-3880', 'mwigzellol@wiley.com', '1f98ac84-3b2f-4b21-8f94-c454db6f66e0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rinaldo Dalgety', '5/18/2024', 3, '7886843571', '810-318-6582', 'rdalgetyom@amazon.com', '96c7d08d-37bc-4eee-9ff2-fa11e8f7b507');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tanny_check Tourle', '9/20/2024', 3, '0953343755', '987-695-6151', 'ttourleon@dot.gov', 'cd9bf0a7-7d24-4060-9124-bb3618eabe66');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Owen Summerlad', '9/20/2024', 1, '7361871071', '367-435-5040', 'osummerladoo@fda.gov', 'fb28c785-b406-4180-a8a0-1181c5aa033f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Mattheus Umpleby', '2/28/2024', 2, '1500775486', '674-679-9920', 'mumplebyop@cbslocal.com', 'eacbc1e7-93aa-4e74-9952-d8c0d27c12c8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ardeen McMurtyr', '5/3/2024', 2, '8245200389', '267-802-4287', 'amcmurtyroq@eventbrite.com', '9bad1ab1-a26e-48ef-8f79-577f5e5ffbc5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brendin Northrop', '1/14/2024', 2, '1751458427', '276-425-7392', 'bnorthropor@google.fr', '6d412020-a4ca-4377-ba44-c31e5cfa47ab');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Deanna Curzey', '3/26/2024', 3, '9875051351', '859-470-1901', 'dcurzeyos@si.edu', '5b45e266-e5c0-4607-9108-b8aafee2f4b3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Modestine Lintill', '3/26/2024', 2, '2185146796', '674-224-7028', 'mlintillot@google.it', 'dfd971d1-2e40-4704-88d6-c8a67990408f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Quintus Rubi', '7/26/2024', 1, '4216528080', '312-217-3466', 'qrubiou@pbs.org', 'b8c65a2b-649f-4e6e-b8c3-0ee276041287');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sinclare Presnail', '6/28/2024', 3, '6314114837', '137-181-1061', 'spresnailov@deliciousdays.com', '7a6e5baf-397b-4b0a-8300-209d47f9e2d4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Moria Battye', '7/17/2024', 2, '4694911198', '908-903-2930', 'mbattyeow@rambler.ru', '3f8c346a-721e-424d-bd2c-612dfc0743c0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lynnell Penhall', '5/25/2024', 3, '6912959036', '400-417-0698', 'lpenhallox@microsoft.com', '2f981efd-5617-4a1e-b221-1d984ebda615');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kendre Di Roberto', '12/16/2023', 3, '2895484148', '909-588-9766', 'kdioy@netscape.com', '641adafe-a251-4694-93ee-3c6148820b88');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Zechariah Kinzel', '12/12/2023', 1, '2863944025', '875-774-0242', 'zkinzeloz@linkedin.com', '4237403f-33c1-42eb-bba5-906ea4a2f314');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Torie Willgress', '11/24/2023', 2, '4163539661', '609-117-6682', 'twillgressp0@nyu.edu', 'd471ad5d-26f5-48f5-bddb-f2fad4c630e5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Torr Vankeev', '6/3/2024', 3, '9227539633', '196-179-3474', 'tvankeevp1@liveinternet.ru', '88d3607a-ec60-46fc-a032-8a0f14419144');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sigrid Merry', '6/21/2024', 1, '1166266299', '664-513-3106', 'smerryp2@cnet.com', '0af7179d-2ea8-4277-a0ca-2165b5578b17');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ally Cheves', '9/20/2024', 1, '2532742173', '758-735-5572', 'achevesp3@arizona.edu', 'b28d7cae-b4ba-4e34-96ed-d583d00eff1a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cicely Faithfull', '1/3/2024', 2, '9499463707', '547-459-2343', 'cfaithfullp4@princeton.edu', 'f8791ce3-58eb-4484-98ec-eb2ecb7b5c15');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Dorie Fookes', '2/8/2024', 3, '8904080209', '880-783-9196', 'dfookesp5@thetimes.co.uk', 'ae733833-dc1d-4852-84db-349edfeaf413');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Isobel Riley', '3/14/2024', 3, '3730277209', '780-605-8352', 'irileyp6@webnode.com', 'c6bf06c1-e8f3-466e-ac39-36d18efb8457');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Timothea Baszkiewicz', '2/21/2024', 3, '6803596644', '410-355-3915', 'tbaszkiewiczp7@wordpress.com', 'c64f638f-7873-45f4-9ca1-8ead5ca020b4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Romeo Hunnaball', '9/11/2024', 3, '2851867550', '736-998-2922', 'rhunnaballp8@goo.ne.jp', 'b1224f2b-6cc1-4c2e-94ef-f240ae9c0566');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bertha Weller', '7/8/2024', 1, '3143952140', '216-550-8123', 'bwellerp9@sogou.com', '5fcb354b-1f9a-4488-b1a5-ff5f5ef4ea26');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bondie Tenpenny', '2/2/2024', 1, '8324531216', '750-976-2660', 'btenpennypa@usa.gov', '7ff94e44-8457-4438-8977-d17cb7bc6d2b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Eal Tournay', '8/28/2024', 1, '5390411990', '593-796-1067', 'etournaypb@latimes.com', '253fd7ac-fd5e-4fe6-865e-6d2f88e4f0e8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Shepperd Simondson', '4/15/2024', 3, '1210421018', '972-261-7260', 'ssimondsonpc@army.mil', '5a63b225-6636-43c7-b4eb-4fb36cc7d72c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Diandra Oake', '3/11/2024', 1, '7828071470', '318-580-5218', 'doakepd@surveymonkey.com', 'df19c8df-d800-49e6-b2cb-ce0bbaf96730');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nariko Lockery', '8/12/2024', 3, '5098367665', '931-671-5871', 'nlockerype@lycos.com', '38aa051a-45c4-4a10-a750-19ab7070fd0d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Frazer Bernier', '8/14/2024', 2, '7205461847', '295-764-3667', 'fbernierpf@nationalgeographic.com', 'edabb72f-aa5d-4485-bcd1-fe1aa9d8d71f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sissy Garrit', '5/1/2024', 1, '9616602037', '779-617-6313', 'sgarritpg@google.nl', 'a9a507f3-14ae-4ea7-93b7-3c5519e439e8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hildagard Santus', '9/9/2024', 2, '5599930216', '185-396-1707', 'hsantusph@miibeian.gov.cn', '868f1445-7061-49eb-b14b-b1040671657d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sibilla Cashen', '6/26/2024', 2, '3843623945', '946-908-1691', 'scashenpi@seattletimes.com', 'd6588617-96a5-44e6-97c2-ebf7c2e2b111');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vasily Winfield', '10/7/2024', 1, '9317619904', '905-331-8295', 'vwinfieldpj@apple.com', '6647fc82-9b05-4de3-b97a-066c87524444');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kit Kobpa', '2/18/2024', 3, '4956313385', '408-536-4276', 'kkobpapk@cargocollective.com', '116a589e-4c50-4498-af4a-3c2be0cda193');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nicola Lapping', '6/2/2024', 2, '0975828837', '621-261-6073', 'nlappingpl@netlog.com', '7a15564d-214c-4f60-9624-1967e108b905');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elita Brownsea', '5/12/2024', 1, '9986699518', '478-826-7971', 'ebrownseapm@pagesperso-orange.fr', '8d3543cb-e5ba-436d-a24e-42e8caa28822');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Wayland Janecki', '9/16/2024', 3, '5272033686', '303-219-5582', 'wjaneckipn@wordpress.org', '9cf92070-af92-463a-be16-c1e3a9dff3fb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rebekah Arendt', '5/25/2024', 1, '3211846821', '571-667-5201', 'rarendtpo@google.pl', '32cec1be-9da9-4759-9fdf-f36a97969d28');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Babette Dumelow', '11/28/2023', 2, '2621604298', '256-568-8735', 'bdumelowpp@weibo.com', '31966658-03b7-4d4f-a8d4-ea3e4454aac2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Padriac Ottery', '10/6/2024', 2, '4232279673', '472-199-2847', 'potterypq@hhs.gov', 'f49deeea-865c-4b3c-ace9-ee1b6475b448');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adelind Risborough', '9/3/2024', 3, '0536938533', '504-641-0782', 'arisboroughpr@virginia.edu', '8db9bc12-05f8-4df0-a2f4-2b97b4f7b101');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Taylor Nockalls', '6/27/2024', 1, '1462423217', '895-841-8553', 'tnockallsps@angelfire.com', '3f194c57-520b-4fef-a66e-d1a4d1f04fe1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Drake Hadden', '10/13/2024', 3, '5369701527', '273-729-7241', 'dhaddenpt@lycos.com', '6fe2f630-6aca-424d-9539-984658cf73f2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nevins Dolohunty', '2/18/2024', 3, '0689051170', '570-285-4097', 'ndolohuntypu@wisc.edu', '000cadcb-b461-44db-a52b-ca1efe107cf4');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ilene Whilder', '8/27/2024', 1, '9500650180', '876-257-5610', 'iwhilderpv@edublogs.org', 'c2bb953e-5bff-4b4a-8d8b-4e2f0ec57450');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cordey Simek', '11/28/2023', 1, '7960149942', '245-933-2223', 'csimekpw@apache.org', '16c75eac-43f0-415a-95d0-b7735810a285');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Corabel Sutworth', '1/25/2024', 3, '2135674057', '355-956-4214', 'csutworthpx@etsy.com', '39a257de-5dcc-4126-8eea-0b7669ef3c91');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Giffy Lorenzin', '10/26/2024', 1, '1532236628', '282-805-9335', 'glorenzinpy@google.es', 'e1e8fad2-1e15-4132-b474-1103c98a132b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Lannie Aloshkin', '4/20/2024', 1, '5775024381', '512-641-6361', 'laloshkinpz@cbc.ca', '05ae1096-d3bd-4964-bbc9-ad22d8cab6a2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Valery_check Josofovitz', '7/11/2024', 2, '5773048810', '816-538-9486', 'vjosofovitzq0@tamu.edu', 'fd71c3a5-a283-4bdc-aa41-33746d42a58f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Boot McLucas', '1/25/2024', 3, '3295345082', '998-808-0688', 'bmclucasq1@geocities.jp', 'afb70fba-64f3-42b1-9122-83b739901dca');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hilario Murrells', '12/17/2023', 3, '2979926884', '285-628-9398', 'hmurrellsq2@booking.com', '2146e4dc-817d-4b56-9343-045650dac5d0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Leann Whellams', '7/26/2024', 1, '3342260710', '692-178-3687', 'lwhellamsq3@fastcompany.com', '1375df68-3339-4ab9-967b-2b7d9ab7c2af');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Rhetta Jowle', '2/12/2024', 1, '3477760671', '889-660-2041', 'rjowleq4@berkeley.edu', '68260e63-eba5-4abb-8198-53c0f37ec1dc');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stepha Laing', '11/17/2023', 3, '9958803630', '388-258-9938', 'slaingq5@dell.com', '3add6880-8886-48b1-acc1-3e086aacb70a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Hannie Baudino', '3/11/2024', 3, '6558475420', '995-385-3555', 'hbaudinoq6@ovh.net', '4743dbbc-bee0-4330-a901-a9604dd5a7f3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bond_check Hencke', '12/21/2023', 3, '1038839268', '486-978-3766', 'bhenckeq7@gmpg.org', '7fbd6a9c-35f1-460f-b584-1392983158d8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Odilia Delacour', '2/23/2024', 1, '6555487376', '505-425-5962', 'odelacourq8@cmu.edu', 'd26484f9-ecdf-4285-bf30-31d9d4d4a070');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alida Hustings', '2/18/2024', 3, '2204590150', '972-884-0167', 'ahustingsq9@sphinn.com', 'aee19dac-d6fc-4bb3-9178-20986f4e1b47');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fania Kernock', '8/16/2024', 2, '4423237272', '702-887-0532', 'fkernockqa@cafepress.com', '1cf2d7ac-f32b-4629-975b-5173e7cdc1b0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Pansy Taill', '7/25/2024', 2, '8777962366', '848-304-9183', 'ptaillqb@ameblo.jp', '4aa49f50-8793-4fc4-a0e5-b04ab38fb582');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Evan Chesshire', '12/29/2023', 1, '6373840144', '995-193-8339', 'echesshireqc@sciencedaily.com', '8c4e2eb0-8ed4-4732-b242-ba87ce209f71');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Beverley Togher', '1/27/2024', 3, '4454640177', '528-529-4067', 'btogherqd@microsoft.com', 'c6d64e26-880c-4a2a-8abf-3d185736cd4c');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Adan Darrington', '11/6/2024', 3, '9603344126', '767-506-4083', 'adarringtonqe@admin.ch', '630c0f8c-5f8e-4733-b183-3499a1e16c3e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gabriello Baskerfield', '1/31/2024', 2, '1415423766', '713-571-0401', 'gbaskerfieldqf@github.io', 'db737b34-ba2d-4614-86b2-ffe9ff70101f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Victoir_check Crepin', '6/27/2024', 1, '4182978989', '203-872-3207', 'vcrepinqg@state.tx.us', 'e7405caa-f114-498b-926e-399c7c50e820');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ericha McNerlin', '5/31/2024', 2, '0666994231', '244-874-9157', 'emcnerlinqh@abc.net.au', '99ec3d89-f42d-4daf-8f4b-c4ef7c6ca3c3');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Isaak Bussel', '4/21/2024', 1, '8397174457', '395-982-2500', 'ibusselqi@hubpages.com', 'c22459f6-4ea2-43c2-b7fa-2a7f8c88185e');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tore Lefridge', '7/10/2024', 2, '7869392324', '998-539-4648', 'tlefridgeqj@ihg.com', '5f9ae092-841f-4ca3-ada4-824814c40ca2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andie Grimes', '8/4/2024', 1, '3339368073', '526-837-8993', 'agrimesqk@dmoz.org', '3e8fc714-0d0b-4f0a-9df6-5afa85f8b4ef');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jordanna Emig', '5/6/2024', 1, '7320521497', '201-719-5408', 'jemigql@vimeo.com', '9aacc2dd-14de-418f-b47c-727e2dc30e10');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Nehemiah Walne', '8/2/2024', 3, '7720977116', '384-487-5920', 'nwalneqm@bloglines.com', '5141131f-577b-4e5b-8102-df34423d917d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Chlo Kubasek', '11/11/2024', 1, '5167273426', '136-755-6139', 'ckubasekqn@cornell.edu', '7375cd07-b0c4-4709-b13f-5b3f08154337');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jewel Beazleigh', '2/6/2024', 2, '3473891407', '127-108-2973', 'jbeazleighqo@ehow.com', 'afdaf761-7446-4ee4-81f6-2f63589997fd');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Jehanna Scardifield', '2/7/2024', 1, '7389317610', '756-830-8970', 'jscardifieldqp@yandex.ru', '007ba658-268d-4e7c-a27d-f6352d64dcce');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ingrid Frushard', '9/4/2024', 3, '5031174568', '687-205-5181', 'ifrushardqq@plala.or.jp', '4a0222ab-69a8-4f42-89e7-20510eae52c8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fredra Souness', '1/24/2024', 3, '7298775844', '279-335-3057', 'fsounessqr@usda.gov', '51c0bc29-5f80-4f3f-8a6c-954806f80756');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Noreen Ferrelli', '1/10/2024', 3, '1584178979', '971-166-2856', 'nferrelliqs@blinklist.com', 'c8ccb5e5-227f-446a-8937-52c67f7138e2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Concordia Muckian', '1/25/2024', 1, '7507636208', '516-771-8017', 'cmuckianqt@meetup.com', 'fe6f2a29-8fce-49b9-b34f-c64b10dbfe0f');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Serene Matz', '11/1/2024', 2, '1626953705', '985-886-8354', 'smatzqu@newsvine.com', '6a3fe0f6-fec0-475c-9cd4-86d77cb95fd5');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Twila Feather', '9/2/2024', 1, '4840117052', '802-419-5146', 'tfeatherqv@yahoo.co.jp', 'db889802-3024-43bc-bfa9-d6a9480a0c64');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Haleigh Hinchshaw', '6/13/2024', 2, '9412172957', '608-781-4383', 'hhinchshawqw@house.gov', 'a8577503-4a42-4a74-8c8f-5db18fd71aa9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Phineas Steinson', '5/16/2024', 1, '3698860657', '524-550-8179', 'psteinsonqx@deviantart.com', '2c49346b-891d-4fad-a11c-dab00c78f679');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Guglielma Navan', '7/3/2024', 2, '3982249742', '902-299-2117', 'gnavanqy@eepurl.com', 'dddbf6cf-063e-4396-b765-ea5eba7dfbfb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Alick_check Byham', '11/1/2024', 3, '8939506435', '141-272-3806', 'abyhamqz@people.com.cn', 'c198c542-eaa8-4d94-8c46-976ae96dd8c2');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Vincents Bethune', '2/7/2024', 3, '5977217011', '761-904-5014', 'vbethuner0@g.co', 'e08f98b8-28f9-4134-86f7-aae090838528');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Inessa Begent', '11/3/2024', 2, '2723117363', '220-395-1204', 'ibegentr1@google.com.au', '999cbafd-c936-40de-be11-be8ab59be843');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Darby Schoenleiter', '1/29/2024', 2, '9799208397', '890-880-9573', 'dschoenleiterr2@gmpg.org', 'fea04ebc-69dd-4a78-9062-f4387e0ee56b');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Johnny Gladdis', '11/16/2023', 2, '6336981770', '700-891-1245', 'jgladdisr3@theglobeandmail.com', 'edcecc61-fba8-4d4e-ba81-dff109ccc70a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Stefania Levesley', '10/29/2024', 2, '9614632391', '947-543-5749', 'slevesleyr4@gizmodo.com', '6e980ece-936e-4c70-807d-d473ba943046');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Bev Bryenton', '1/1/2024', 3, '4765867598', '550-622-4562', 'bbryentonr5@google.nl', '7c1664de-6b6d-4ec4-b615-c27765baed4d');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Andrei Coye', '9/26/2024', 1, '5263236048', '755-117-0430', 'acoyer6@blinklist.com', '0e70ffdb-e09f-4110-b962-24120335f8e6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Tobey Blevin', '11/16/2023', 2, '8888598093', '378-513-6953', 'tblevinr7@bravesites.com', '890219d7-1064-40c1-96d8-9ec062c3fc60');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cayla Jessopp', '3/11/2024', 2, '5978919686', '646-158-1364', 'cjessoppr8@omniture.com', '132bd48c-c93a-4133-a340-ee20c56f37eb');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Clare Bernardinelli', '4/5/2024', 3, '4899225093', '563-682-5498', 'cbernardinellir9@nydailynews.com', 'cf8af0f4-d95c-4e6a-b3d1-8f44794f4c1a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Salvador MacGown', '11/30/2023', 1, '6521887602', '411-469-7251', 'smacgownra@intel.com', '343ffc39-ca22-48c5-b4f4-428b4868290a');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ewart_check Newcome', '5/5/2024', 1, '9507846937', '397-624-8118', 'enewcomerb@skype.com', '4857e520-3b81-4b11-9851-68eb0402bebe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Elliott_check Gergus', '11/21/2023', 3, '1733428115', '221-849-6107', 'egergusrc@fda.gov', '896441a3-fbf8-4b4f-a823-5cde36bdd9e8');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cindi Eddison', '7/25/2024', 3, '1898075336', '492-666-8924', 'ceddisonrd@biblegateway.com', '3dd8e7d4-7f0e-4a8f-b175-469f89d35ed6');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Brennen Tregale', '2/4/2024', 3, '1202617994', '461-931-5623', 'btregalere@imageshack.us', '49b0c72b-f9a2-4b54-834d-be2e0624ffd1');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Ingelbert Casetti', '1/24/2024', 1, '3692305955', '512-879-7535', 'icasettirf@amazon.com', 'ef755e30-90f1-4425-901a-0d82f34a1668');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Sophie De Cleyne', '12/19/2023', 2, '1353275339', '219-214-3072', 'sderg@tripod.com', '73179852-1e05-4406-b12c-9cf24d5b91f0');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Fraser Catonne', '10/17/2024', 2, '0803672251', '476-280-0978', 'fcatonnerh@columbia.edu', 'c434a8a2-1d7c-493a-afb6-5f50914210b9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Temp_check Batcheldor', '5/11/2024', 1, '1536157192', '942-408-9699', 'tbatcheldorri@purevolume.com', '5d3fad88-e8b6-4bed-9a83-ed428f95da90');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Easter Osgordby', '10/4/2024', 1, '4162268406', '946-639-2256', 'eosgordbyrj@shinystat.com', '60ea5cb9-e394-443c-a03d-a29aec2f99ad');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Kirsten Buxcy', '10/5/2024', 1, '0815371683', '983-824-5848', 'kbuxcyrk@jugem.jp', '0e3e7569-053b-4335-845d-7a38f5ad6698');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Cristionna Kop', '10/21/2024', 2, '3160545291', '618-515-1186', 'ckoprl@github.io', '8b949a58-cea5-42cd-852d-42a0b21163be');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Romona_check Forgie', '1/4/2024', 3, '7916560404', '760-873-4413', 'rforgierm@webnode.com', 'a7930491-d1dd-4ef4-a747-4a0d0d718434');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gilly Shemelt', '9/26/2024', 2, '2086486882', '564-498-7006', 'gshemeltrn@army.mil', '3ec132c5-ba0d-4cd6-9c0c-041fb0b42bbe');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Asher Batts', '3/28/2024', 2, '2251158642', '271-997-0856', 'abattsro@addtoany.com', '53013371-0d1d-484a-b892-9a6005ffb0a9');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Amalee Blunt', '7/26/2024', 3, '0994325753', '752-822-5180', 'abluntrp@guardian.co.uk', 'aa600128-6cc2-48db-b498-06ecfcb9faee');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Francisco_check Brudenell', '1/28/2024', 3, '3624222946', '263-942-8593', 'fbrudenellrq@google.ru', '1e6dfeab-f00f-4a3a-8890-4bdfd1f8b301');
insert into Customers (name, DateOfBirth, Gender, CitizenId, Phone, Email, CustomerId) values ('Gunther Terne', '11/9/2024', 3, '5662914041', '454-351-8629', 'gternerr@stumbleupon.com', 'd619935d-0c9c-49b8-8036-208e33d35531');


GO 
--ranking

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

GO
-- card



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



GO

--reservation seed


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
        SELECT @TableId = TableId FROM TableDetail WHERE BranchId = @BranchId ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

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



GO
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

GO



-- seed invoice 

CREATE OR ALTER PROCEDURE CreateInvoiceAndUpdateCustomerCard
    @OrderId UNIQUEIDENTIFIER,
    @paymentMethod NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu hóa đơn đã tồn tại cho OrderId
    IF EXISTS (SELECT 1 FROM Orders o JOIN Invoices i ON i.OrderId = o.Id WHERE o.Id = @OrderId)
    BEGIN
        RAISERROR('Invoice for this order already exists', 16, 1);
        RETURN;
    END

    -- Khai báo biến
    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @Total DECIMAL(18, 2);
    DECLARE @AfterDiscount DECIMAL(18, 2);
    DECLARE @InvoiceId UNIQUEIDENTIFIER;
    DECLARE @bonusPoint INT;
    DECLARE @Discount INT;
    DECLARE @ReservationDate DATE;  -- Biến lưu trữ ngày đặt chỗ (DatedOn từ Reservation)
    DECLARE @ReservationId UNIQUEIDENTIFIER;  -- Biến lưu trữ ReservationId
    DECLARE @TableId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation
    DECLARE @BranchId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation

    -- 1. Lấy thông tin từ bảng Orders và Reservation
    SELECT 
        @CustomerId = r.CustomerId,
        @Total = o.Total,
        @ReservationDate = r.DatedOn,  -- Lấy ngày đặt chỗ từ Reservation
        @ReservationId = r.Id,         -- Lấy ReservationId
        @TableId = r.TableId,
        @BranchId = r.BranchId           -- Lấy TableId từ Reservation
    FROM Orders o
    JOIN Reservation r ON r.Id = o.ReservationId
    WHERE o.Id = @OrderId;

    -- Kiểm tra nếu không tìm thấy đơn hàng
  

    -- 2. Kiểm tra sự tồn tại của thẻ khách hàng và tính toán giảm giá
    IF NOT EXISTS (SELECT 1 FROM Cards c WHERE c.CustomerId = @CustomerId)
    BEGIN
        -- Nếu không có thẻ, gán Discount = 0
        SET @Discount = 0;
    END
    ELSE
    BEGIN
        -- Lấy thông tin giảm giá từ bảng Cards và Rankings nếu khách hàng có thẻ
        SELECT @Discount = r.Discount
        FROM Cards c
        JOIN Rankings r ON c.RankingId = r.Id
        WHERE c.CustomerId = @CustomerId;
    END

    -- 3. Tính toán giá trị AfterDiscount
    SET @AfterDiscount = (100 - @Discount) / 100.0 * @Total;

    -- 4. Tính điểm thưởng
    SET @bonusPoint = FLOOR(@AfterDiscount / 100000);  -- Quy đổi 100.000 VND = 1 điểm

    -- 5. Tạo hóa đơn mới trong bảng Invoices
    SET @InvoiceId = NEWID();  -- Tạo InvoiceId mới

    INSERT INTO Invoices (Id, OrderId, DatedOn, Total, PaymentMethod, Paid, AfterDiscount, BonusPoint, BranchId)
    VALUES (@InvoiceId, @OrderId, @ReservationDate, @Total, @paymentMethod, 0, @AfterDiscount, @bonusPoint, @BranchId);  -- Sử dụng @ReservationDate thay vì GETDATE()

    -- 6. Cập nhật điểm số cho thẻ khách hàng
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId)
    BEGIN
        -- Cập nhật thẻ khách hàng
        UPDATE Cards
        SET AccumulatedPoints = AccumulatedPoints + @bonusPoint
        WHERE CustomerId = @CustomerId;
    END
END;



GO





GO

DECLARE @OrderId1 UNIQUEIDENTIFIER;

-- Lấy tất cả OrderId từ bảng Orders
DECLARE OrderCursor CURSOR FOR 
SELECT o.Id FROM Orders o  WHERE Status = 2  ;  -- Chỉ lấy các Order chưa có hóa đơn (Status = 1)

OPEN OrderCursor;

FETCH NEXT FROM OrderCursor INTO @OrderId1;

-- Lặp qua tất cả các OrderId để tạo Invoice
WHILE @@FETCH_STATUS = 0
BEGIN
    -- In OrderId đang xử lý
    -- Gọi stored procedure CreateInvoiceAndUpdateCustomerCard với mỗi OrderId
    EXEC CreateInvoiceAndUpdateCustomerCard @OrderId = @OrderId1, @paymentMethod = 'cash';

    FETCH NEXT FROM OrderCursor INTO @OrderId1;
END

CLOSE OrderCursor;
DEALLOCATE OrderCursor;

GO


GO

CREATE OR ALTER PROCEDURE UpdatePaidInvoice
    @InvoiceId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem hóa đơn có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM Invoices WHERE Id = @InvoiceId)
        BEGIN
            RAISERROR('Invoice not found.', 16, 1);
            RETURN;
        END

        -- Cập nhật trường Paid thành 1 (đã thanh toán)
        UPDATE Invoices
        SET Paid = 1
        WHERE Id = @InvoiceId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;


GO


DECLARE @InvoiceId UNIQUEIDENTIFIER;

DECLARE InvoiceCursor CURSOR FOR 
SELECT Id FROM Invoices WHERE Paid = 0;  -- Chỉ lấy các hóa đơn chưa thanh toán

OPEN InvoiceCursor;

FETCH NEXT FROM InvoiceCursor INTO @InvoiceId;

-- Lặp qua tất cả các InvoiceId để cập nhật Paid thành 1
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Gọi stored procedure UpdatePaidInvoice với mỗi InvoiceId chưa thanh toán
    EXEC UpdatePaidInvoice @InvoiceId = @InvoiceId;

    FETCH NEXT FROM InvoiceCursor INTO @InvoiceId;
END

CLOSE InvoiceCursor;
DEALLOCATE InvoiceCursor;






GO

-- Declare variables
DECLARE @BranchId UNIQUEIDENTIFIER;
DECLARE @EmployeeId UNIQUEIDENTIFIER;

-- Cursor to loop through each branch
DECLARE BranchCursor CURSOR FOR
SELECT BranchId FROM Branches WHERE ManagerId IS NULL;

OPEN BranchCursor;
FETCH NEXT FROM BranchCursor INTO @BranchId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Select a random employee from the current branch
    SELECT TOP 1 @EmployeeId = Id
    FROM Employees
    WHERE BranchId = @BranchId
    ORDER BY NEWID();

    -- Update the branch with the selected employee as the manager
    UPDATE Branches
    SET ManagerId = @EmployeeId
    WHERE BranchId = @BranchId;

    -- Fetch the next branch
    FETCH NEXT FROM BranchCursor INTO @BranchId;
END

-- Clean up the cursor
CLOSE BranchCursor;
DEALLOCATE BranchCursor;

GO




-- Insert WorkHistory for each employee
INSERT INTO WorkHistory (Id, EmployeeId, BranchId, StartDate, ResignDate, DepartmentId)
SELECT 
    NEWID() AS Id,
    e.Id AS EmployeeId,
    e.BranchId AS BranchId,
    '2024-01-01' AS StartDate,
    NULL AS ResignDate,
    e.DepartmentId AS DepartmentId
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM WorkHistory wh 
    WHERE wh.EmployeeId = e.Id
);
GO


GO

-- Declare variables
DECLARE @BranchId UNIQUEIDENTIFIER;
DECLARE @EmployeeId UNIQUEIDENTIFIER;
DECLARE @EmployeeName NVARCHAR(100);
DECLARE @Username NVARCHAR(200);
DECLARE @Password NVARCHAR(30) = 'admin123'; -- Default password for admin accounts
DECLARE @Role NVARCHAR(10) = 'Admin';
DECLARE @Salary INT;
DECLARE @Department UNIQUEIDENTIFIER;
Declare @BranchName NVARCHAR(100)
-- Cursor to loop through each branch
DECLARE BranchCursor CURSOR FOR
SELECT BranchId FROM Branches;

OPEN BranchCursor;
FETCH NEXT FROM BranchCursor INTO @BranchId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Generate a new EmployeeId
    SET @EmployeeId = NEWID();
    SELect @Salary = BaseSalary, @Department = DepartmentId from Departments where DepartmentName = N'Quản lý'
    -- Generate a random employee name
    select @BranchName = name from Branches where BranchId = @BranchId
    SET @EmployeeName =REPLACE( 'Admin_' + @BranchName, ' ', '');

    -- Generate a username by combining the employee name and branch ID
     PRINT @username
    -- Insert the new employee into the Employees table
    INSERT INTO Employees (Id, Name, Dob, Gender, Salary, StartDate, DepartmentId, BranchId)
    VALUES (@EmployeeId, @EmployeeName, '1980-01-01', 'Male', @Salary, GETDATE(), @Department, @BranchId);

    -- Insert the new account into the Account table
    INSERT INTO Account (Id, EmployeeId, Username, [Password], Role)
    VALUES (NEWID(), @EmployeeId, @EmployeeName, @Password, @Role);

    -- Fetch the next branch
    FETCH NEXT FROM BranchCursor INTO @BranchId;
END

-- Clean up the cursor
CLOSE BranchCursor;
DEALLOCATE BranchCursor;

GO

select count(*) from Account
select count (*) as Branches from Branches
select count (*) as BranchDishes from BranchDishes
select count (*) as Dishes from Dishes
select count (*) as Sections from Sections
select count (*) as Departments from Departments
select count (*) as Employees from Employees
select count (*) as Customers from Customers
select count (*) as Rankings from Rankings
select count (*) as Cards from Cards
select count (*) as Reservation from Reservation
select count (*) as Orders from Orders
select count (*) as OrderDetail from OrderDetail
select count(*) as invoices from invoices
select * from WorkHistory


-- DELETE FROM OrderDetail;
-- DELETE FROM Orders;
-- DELETE FROM Reservation;
-- DELETE FROM Cards;
-- DELETE FROM Rankings;
-- DELETE FROM Customers;
-- DELETE FROM Employees;
-- DELETE FROM Departments;
-- DELETE FROM Sections;
-- DELETE FROM Dishes;
-- DELETE FROM BranchDishes;
-- DELETE FROM Branches;
-- DELETE FROM Invoices;



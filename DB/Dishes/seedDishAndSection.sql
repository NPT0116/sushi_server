use sushiDB;
go;




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

INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spicy Tuna Roll', 12, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Caesar Salad', 8, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'French Fries', 5, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'BBQ Ribs', 20, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Margherita Pizza', 15, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Cheese Burger', 7, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spring Rolls', 6, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lemonade', 4, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Apple Pie', 5, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Sushi Platter', 25, 'E518919A-5662-40C5-8468-AE4A3CE70A80');

-- Add more random dishes with varying SectionId and prices
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Wings', 10, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Steak', 30, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Lobster Bisque', 18, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chocolate Cake', 6, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Margarita', 8, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vegetable Stir Fry', 11, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Bacon Burger', 14, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Chicken Nuggets', 6, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Ice Cream Sundae', 5, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Greek Salad', 9, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');

-- Continue adding more dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Spaghetti Bolognese', 12, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Orange Juice', 3, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Shrimp Cocktail', 15, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Nachos', 7, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Vanilla Milkshake', 4, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chicken Caesar Wrap', 11, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Crab Cakes', 16, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Stuffed Mushrooms', 9, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fried Shrimp', 13, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Cauliflower Bites', 7, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');

-- Continue with more dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Mac and Cheese', 8, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Sashimi Platter', 18, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pasta Alfredo', 14, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Coke', 3, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Brownie', 5, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Tuna Tartare', 14, 'E518919A-5662-40C5-8468-AE4A3CE70A80');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Beef Tacos', 10, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fried Rice', 8, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pancakes', 6, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Kids Chicken Tenders', 6, 'B2A4D6E1-1F54-4A22-9E77-789ABCDEF012');

-- Adding the remaining dishes
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Onion Rings', 5, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Grilled Salmon', 17, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Miso Soup', 4, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Chocolate Mousse', 7, '242DC005-A807-40E2-BAEF-CAF01F3CCD24');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Avocado Toast', 6, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Roast Chicken', 12, '9BD51261-8C72-4976-8F7E-6C16772A6001');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Pomegranate Juice', 4, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Fish and Chips', 10, 'C3F5D7B4-8F44-4BB0-ABC8-654321FEDCBA');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Tomato Basil Soup', 5, 'A5D6A781-3D0A-4B89-93A3-123456789ABC');
INSERT INTO Dishes (DishId, DishName, CurrentPrice, SectionId) VALUES (NEWID(), 'Mango Smoothie', 5, '1991D314-DB2B-47EB-88DC-0F1CD8A60B45');

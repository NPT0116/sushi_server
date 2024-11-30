use sushiDB;
go




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


select * from Dishes

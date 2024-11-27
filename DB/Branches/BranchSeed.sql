
use sushiDB;


go

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


go;

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
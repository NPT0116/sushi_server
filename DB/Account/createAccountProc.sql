CREATE OR ALTER PROCEDURE createAccount 
    @password VARCHAR(30),
    @Name NVARCHAR(40),
    @DateOfBirth DATETIME,
    @Gender INT,
    @CitizenId VARCHAR(15),
    @Phone VARCHAR(10),
    @Email VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Bắt đầu transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Tạo CustomerId mới
        DECLARE @customerId UNIQUEIDENTIFIER = NEWID();

        -- Insert vào bảng Customers
        INSERT INTO Customers (CustomerId, Name, DateOfBirth, Gender, CitizenId, Phone, Email)
        VALUES (@customerId, @Name, @DateOfBirth, @Gender, @CitizenId, @Phone, @Email);

        -- Insert vào bảng Account
<<<<<<< HEAD
        INSERT INTO Account (Id,CustomerId, Username, [Password], Role)
        VALUES (NEWID(),@customerId, @Email, @password, 'Customer');
=======
        INSERT INTO Account (Id,CustomerId, Username, [Password], IsEmployee)
        VALUES (NEWID(),@customerId, @Email, @password, 0);
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e

        -- Nếu không có lỗi, commit transaction
        COMMIT TRANSACTION;
        PRINT 'update successfully'
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi, rollback transaction
        ROLLBACK TRANSACTION;
    END CATCH
END;




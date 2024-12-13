CREATE OR ALTER PROCEDURE createAccount 
    @password VARCHAR(15),
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
        INSERT INTO Account (Id,CustomerId, Username, [Password], IsEmployee)
        VALUES (NEWID(),@customerId, @Email, @password, 0);

        -- Nếu không có lỗi, commit transaction
        COMMIT TRANSACTION;
        PRINT 'update successfully'
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi, rollback transaction
        ROLLBACK TRANSACTION;
    END CATCH
END;




CREATE OR ALTER PROCEDURE loginUser
    @password VARCHAR(30),
    @username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables to hold the results
    DECLARE @customerId UNIQUEIDENTIFIER;
    DECLARE @employeeId UNIQUEIDENTIFIER;
    DECLARE @role VARCHAR(10);
    DECLARE @storedPassword VARCHAR(20);

    -- Check if the username exists in the Account table
    SELECT 
        @customerId = CustomerId,
        @employeeId = EmployeeId,
        @role = Role,
        @storedPassword = Password
    FROM Account
    WHERE Username = @username;

    -- If no user found, return error
    IF @customerId IS NULL AND @employeeId IS NULL
    BEGIN
        RAISERROR('Username not found.', 16, 1);
        RETURN;
    END

    -- Check if the password matches
    IF @storedPassword != @password
    BEGIN
        RAISERROR('Incorrect password.', 16, 1);
        RETURN;
    END

    -- Return success and the appropriate ID based on Role
    IF @role = 'Employee'
    BEGIN
        SELECT 'Login successful' AS Message, @employeeId AS EmployeeId;
    END
    ELSE IF @role = 'Customer'
    BEGIN
        SELECT 'Login successful' AS Message, @customerId AS CustomerId;
    END
    ELSE
    BEGIN
        SELECT 'Login successful' AS Message, @employeeId  AS Role;
    END
END;


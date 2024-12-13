CREATE OR ALTER PROCEDURE loginUser
    @password VARCHAR(20),
    @username VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables to hold the results
    DECLARE @customerId UNIQUEIDENTIFIER;
    DECLARE @employeeId UNIQUEIDENTIFIER;
    DECLARE @isEmployee BIT;
    DECLARE @storedPassword VARCHAR(20);

    -- Check if the username exists in the Account table
    SELECT 
        @customerId = CustomerId,
        @employeeId = EmployeeId,
        @isEmployee = IsEmployee,
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

    -- Return success and the appropriate ID based on IsEmployee flag
    IF @isEmployee = 1
    BEGIN
        SELECT 'Login successful' AS Message, @employeeId AS EmployeeId;
    END
    ELSE
    BEGIN
        SELECT 'Login successful' AS Message, @customerId AS CustomerId;
    END
END;

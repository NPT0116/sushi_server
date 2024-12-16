CREATE OR ALTER PROCEDURE loginUser
    @password VARCHAR(30),
    @username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables to hold the results
    DECLARE @customerId UNIQUEIDENTIFIER;
    DECLARE @employeeId UNIQUEIDENTIFIER;
<<<<<<< HEAD
    DECLARE @role VARCHAR(10);
=======
    DECLARE @isEmployee BIT;
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    DECLARE @storedPassword VARCHAR(20);

    -- Check if the username exists in the Account table
    SELECT 
        @customerId = CustomerId,
        @employeeId = EmployeeId,
<<<<<<< HEAD
        @role = Role,
=======
        @isEmployee = IsEmployee,
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
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

<<<<<<< HEAD
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

=======
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
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e

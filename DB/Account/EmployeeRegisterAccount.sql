GO
CREATE OR ALTER PROCEDURE createEmployeeAccount
<<<<<<< HEAD
    @employeeId UNIQUEIDENTIFIER,
    @Role VARCHAR(10)
=======
    @employeeId UNIQUEIDENTIFIER
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
AS
BEGIN
    -- Kiểm tra xem employeeId có tồn tại trong bảng Employees không
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE Id = @employeeId)
    BEGIN
        -- Nếu không tìm thấy employeeId, trả về lỗi
        RAISERROR('Cant find employeeID', 16, 1);
        RETURN;
    END

    -- Khai báo các biến để lưu thông tin của nhân viên và chi nhánh
    DECLARE @EmployeeName NVARCHAR(100);
    DECLARE @BranchName NVARCHAR(100);
    DECLARE @Username NVARCHAR(200);
    DECLARE @Password NVARCHAR(30) = '123'; -- Mật khẩu mặc định là 123

    -- Lấy tên của nhân viên và tên chi nhánh
    SELECT 
        @EmployeeName = e.Name, 
        @BranchName = b.Name
    FROM 
        Employees e
    INNER JOIN 
        Branches b ON e.BranchId = b.BranchId
    WHERE 
        e.Id = @employeeId;

    -- Tạo username bằng cách kết hợp tên nhân viên và tên chi nhánh
    SET @Username = REPLACE(@EmployeeName + @BranchName, ' ', '');
    -- Chèn vào bảng Account
    DECLARE @id UNIQUEIDENTIFIER = NewId();
<<<<<<< HEAD
    INSERT INTO Account (Id, Username, [Password], EmployeeId,Role)
    VALUES (@id, @Username, @Password, @employeeId, @Role);  -- IsEmployee = 1 cho tài khoản nhân viên
=======
    INSERT INTO Account (Id, Username, [Password], EmployeeId,IsEmployee)
    VALUES (@id, @Username, @Password, @employeeId, 1);  -- IsEmployee = 1 cho tài khoản nhân viên
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    select @id as Id , @Username as Username, @Password as password, @employeeId as EmployeeId

END;

<<<<<<< HEAD




=======
EXEC createEmployeeAccount @employeeId = 'dfdca4da-240e-4eab-8a77-00c80aa66526';
select  * from Account
select top 1 * from Employees e JOIN Branches b on b.BranchId = e.BranchId  where e.id = 'dfdca4da-240e-4eab-8a77-00c80aa66526'

select top 1 * from Reservation ORDER by DatedOn DESC
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e

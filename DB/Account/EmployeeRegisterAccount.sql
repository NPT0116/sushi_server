GO
CREATE OR ALTER PROCEDURE createEmployeeAccount
    @employeeId UNIQUEIDENTIFIER,
    @Role VARCHAR(10)
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
    INSERT INTO Account (Id, Username, [Password], EmployeeId,Role)
    VALUES (@id, @Username, @Password, @employeeId, @Role);  -- IsEmployee = 1 cho tài khoản nhân viên
    select @id as Id , @Username as Username, @Password as password, @employeeId as EmployeeId

END;






CREATE OR ALTER PROCEDURE CreateInvoiceAndUpdateCustomerCard
    @OrderId UNIQUEIDENTIFIER,
    @paymentMethod NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu hóa đơn đã tồn tại cho OrderId
    IF EXISTS (SELECT 1 FROM Orders o JOIN Invoices i ON i.OrderId = o.Id WHERE o.Id = @OrderId)
    BEGIN
        RAISERROR('Invoice for this order already exists', 16, 1);
        RETURN;
    END

    -- Khai báo biến
    DECLARE @CustomerId UNIQUEIDENTIFIER;
    DECLARE @Total BIGINT;
    DECLARE @AfterDiscount BIGINT;
    DECLARE @InvoiceId UNIQUEIDENTIFIER;
    DECLARE @bonusPoint INT;
    DECLARE @Discount INT;
    DECLARE @ReservationDate DATE;  -- Biến lưu trữ ngày đặt chỗ (DatedOn từ Reservation)
    DECLARE @ReservationId UNIQUEIDENTIFIER;  -- Biến lưu trữ ReservationId
    DECLARE @TableId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation
    DECLARE @BranchId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation

    -- 1. Lấy thông tin từ bảng Orders và Reservation
    SELECT 
        @CustomerId = r.CustomerId,
        @Total = o.Total,
        @ReservationDate = r.DatedOn,  -- Lấy ngày đặt chỗ từ Reservation
        @ReservationId = r.Id,         -- Lấy ReservationId
        @TableId = r.TableId,
        @BranchId = r.BranchId           -- Lấy TableId từ Reservation
    FROM Orders o
    JOIN Reservation r ON r.Id = o.ReservationId
    WHERE o.Id = @OrderId;

    -- Kiểm tra nếu không tìm thấy đơn hàng
    IF @CustomerId IS NULL
    BEGIN
        RAISERROR('OrderId không tồn tại hoặc không tìm thấy khách hàng', 16, 1);
        RETURN;
    END

    -- 2. Kiểm tra sự tồn tại của thẻ khách hàng và tính toán giảm giá
    IF NOT EXISTS (SELECT 1 FROM Cards c WHERE c.CustomerId = @CustomerId)
    BEGIN
        -- Nếu không có thẻ, gán Discount = 0
        SET @Discount = 0;
    END
    ELSE
    BEGIN
        -- Lấy thông tin giảm giá từ bảng Cards và Rankings nếu khách hàng có thẻ
        SELECT @Discount = r.Discount
        FROM Cards c
        JOIN Rankings r ON c.RankingId = r.Id
        WHERE c.CustomerId = @CustomerId;
    END

    -- 3. Tính toán giá trị AfterDiscount
    SET @AfterDiscount = (100 - @Discount) / 100.0 * @Total;

    -- 4. Tính điểm thưởng
    SET @bonusPoint = FLOOR(@AfterDiscount / 100000);  -- Quy đổi 100.000 VND = 1 điểm
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId and Valid = 1)
    BEGIN
        -- Cập nhật thẻ khách hàng
        UPDATE Cards
        SET AccumulatedPoints = AccumulatedPoints + @bonusPoint
        WHERE CustomerId = @CustomerId and Valid = 1;
    END
    ELSE
    BEGIN
    SET @bonusPoint = 0
    END
    -- 5. Tạo hóa đơn mới trong bảng Invoices
    SET @InvoiceId = NEWID();  -- Tạo InvoiceId mới

    INSERT INTO Invoices (Id, OrderId, DatedOn, Total, PaymentMethod, Paid, AfterDiscount, BonusPoint, BranchId)
    VALUES (@InvoiceId, @OrderId, @ReservationDate, @Total, @paymentMethod, 0, @AfterDiscount, @bonusPoint, @BranchId);  -- Sử dụng @ReservationDate thay vì GETDATE()

    -- 6. Cập nhật điểm số cho thẻ khách hàng


    -- 7. Cập nhật trạng thái đơn hàng thành "Invoiced"
    UPDATE Orders
    SET Status = 2
    WHERE Id = @OrderId;

    -- 8. Cập nhật lại Reservation, đặt TableId thành NULL
    UPDATE Reservation
    SET  Status = 2  -- Cập nhật trạng thái thành "In Progress" và TableId thành NULL
    WHERE Id = @ReservationId;

    -- 9. Cập nhật lại TableDetail, đặt trạng thái của bàn về trạng thái "available" hoặc "vacant"
    UPDATE TableDetail
    SET Status = 0  -- Giả sử '1' là trạng thái "available" hoặc "vacant"
    WHERE TableId = @TableId;

    -- 10. Trả về thông tin hóa đơn mới tạo
    SELECT 
        CAST(Total AS BIGINT) AS Total,
        CAST(PaymentMethod AS NVARCHAR(MAX)) AS PaymentMethod,
        CAST(Id AS UNIQUEIDENTIFIER) AS Id,
        CAST(AfterDiscount AS BIGINT) AS AfterDiscount,
        CAST(BonusPoint AS INT) AS BonusPoint,
        CAST(Paid AS BIT) AS Paid,
        CAST(DatedOn AS DATETIME2) AS DatedOn,
        CAST(OrderId AS UNIQUEIDENTIFIER) AS OrderId,
        CAST(BranchId AS UNIQUEIDENTIFIER) AS BranchId
    FROM Invoices 
    WHERE Id = @InvoiceId;
    
END

GO

CREATE OR ALTER PROCEDURE GetDailyRevenueByBranch
    @BranchId UNIQUEIDENTIFIER,
    @Date DATE
AS
BEGIN
    SET NOCOUNT ON;

  

        -- Tính tổng doanh thu trong ngày của BranchId thông qua Reservation
        SELECT 
            SUM(CAST(i.AfterDiscount AS BIGINT)) AS TotalRevenue        FROM 
            Invoices i
        JOIN 
            Orders o ON o.Id = i.OrderId
        JOIN 
            Reservation r ON r.Id = o.ReservationId -- Thêm join với Reservation
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND r.BranchId = @BranchId  -- Kiểm tra BranchId từ Reservation
            AND CAST(i.DatedOn AS DATE) = @Date  -- Lọc theo ngày
        GROUP BY 
            r.BranchId;

END;





go
CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
    @BranchId UNIQUEIDENTIFIER,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

        -- Truy vấn doanh thu theo ngày cho BranchId trong khoảng thời gian từ @StartDate đến @EndDate
        SELECT 
            CAST(i.DatedOn AS DATE) AS RevenueDate,  -- Chỉ lấy ngày
            SUM(i.AfterDiscount) AS TotalRevenue
        FROM 
            Invoices i
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND BranchId = @BranchId  -- Lọc theo BranchId
            AND CAST(i.DatedOn AS DATE) >= @StartDate  -- Lọc từ ngày bắt đầu
            AND CAST(i.DatedOn AS DATE) <= @EndDate  -- L
        GROUP BY 
            i.DatedOn 
        ORDER BY 
            i.DatedOn
END;



GO
--Get all Procedure

CREATE OR ALTER PROCEDURE GetAllDishes
    @DishName NVARCHAR(50) = NULL,
    @MinPrice INT = NULL,
    @MaxPrice INT = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 10,
    @SectionId UNIQUEIDENTIFIER = NULL,
    @BranchId UNIQUEIDENTIFIER = NULL,
    @TotalRecords INT OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu PageNumber hoặc PageSize NULL, thì trả về toàn bộ kết quả
    BEGIN
        -- Có phân trang
        SELECT distinct d.DishId, DishName, CurrentPrice, SectionId
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE (@BranchId is null or (bd.BranchId = @BranchId and bd.[Status] = 1)) and (@SectionId is null or @SectionId = d.SectionId) and (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
        ORDER BY DishName 
        OFFSET (@PageNumber - 1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        SELECT  @TotalRecords = count(distinct d.DishId) 
        FROM Dishes d join BranchDishes bd on bd.DishId = d.DishId
        WHERE (@BranchId is null or (bd.BranchId = @BranchId and bd.[Status] = 1)) and (@SectionId is null or @SectionId = d.SectionId) and (@DishName IS NULL OR DishName LIKE @DishName + '%')
          AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
          AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)
    END
END;






GO
create or alter PROCEDURE getallemployees
    @BranchId UNIQUEIDENTIFIER = NULL, 
    @DepartmentId UNIQUEIDENTIFIER = NULL, 
    @Name NVARCHAR(50) = NULL,
  @PageNumber INT = 1,
    @PageSize INT = 10,
    @TotalRecord INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    Select e.Id, e.Name, e.Dob, e.Gender, e.Salary, b.BranchId as BranchId, b.Name as BranchName,  e.DepartmentId as DepartmentId, d.DepartmentName as DepartmentName
    from Employees e join Branches b on b.BranchId = e.BranchId join Departments d on d.DepartmentId = e.DepartmentId
    where (@BranchId is Null OR @BranchId = e.BranchId ) and (@DepartmentId is null or @DepartmentId = e.DepartmentId) AND
    (@Name is NULL or e.Name LIKE @Name + '%' )
    Order by e.Name
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT @TotalRecord = count(*) 
    from Employees e 
    where (@BranchId is Null OR @BranchId = e.BranchId ) and (@DepartmentId is null or @DepartmentId = e.DepartmentId) AND
    (@Name is NULL or e.Name LIKE @Name + '%' )
    
END 

GO




GO

CREATE OR ALTER PROCEDURE UpdatePaidInvoice
    @InvoiceId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem hóa đơn có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM Invoices WHERE Id = @InvoiceId)
        BEGIN
            RAISERROR('Invoice not found.', 16, 1);
            RETURN;
        END

        -- Cập nhật trường Paid thành 1 (đã thanh toán)
        UPDATE Invoices
        SET Paid = 1
        WHERE Id = @InvoiceId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;



GO
CREATE OR ALTER PROCEDURE customerSubmitReservation
    @note NVARCHAR(50),
    @datedOn NVARCHAR(50),  -- Input as VARCHAR, will be converted to DATETIME2
    @customerId UNIQUEIDENTIFIER,
    @branchId UNIQUEIDENTIFIER,
    @totalPeople INT,
    @id UNIQUEIDENTIFIER OUT
AS
BEGIN
    -- Kiểm tra xem customerId có tồn tại trong bảng Customers không
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerId = @customerId)
    BEGIN
        RAISERROR('Cant find customer id in db', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem branchId có tồn tại trong bảng Branches không
    IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @branchId)
    BEGIN
        RAISERROR('Cant find branch id in db', 16, 1);
        RETURN;
    END

 IF CHARINDEX('T', @datedOn) > 0 AND LEN(@datedOn) = 16
    BEGIN
        SET @datedOn = @datedOn + ':00';  -- Thêm ":00" vào cuối để đảm bảo phần giây
    END

    -- Chuyển đổi @datedOn từ NVARCHAR sang DATETIME2
    DECLARE @convertedDatedOn DATETIME2;
    SET @convertedDatedOn = CAST(@datedOn AS DATETIME2);

    -- Tạo một ID mới cho Reservation
    SET @id = NEWID();

    -- Insert vào bảng Reservation
    INSERT INTO Reservation (id, Note, DatedOn, CustomerId, BranchId, TotalPeople, [Status])
    VALUES (@id, @note, @convertedDatedOn, @customerId, @branchId, @totalPeople, 0);

END;



go
create or alter PROC createOrderFromReservation
@reservationId UNIQUEIDENTIFIER,
@orderId UNIQUEIDENTIFIER OUT
AS
BEGIN
    if not exists (select 1 from Reservation where @reservationId = Id)
    BEGIN
        RAISERROR('cant find reservationId in db', 16,1);
        RETURN;
    END 
    set @orderId = NEWID();
    insert into Orders (Id, Total, LastModified, [Status], ReservationId)
    values (@orderId, 0, GETDATE(), 2, @reservationId )
END

go
create or alter PROCEDURE createOrderDetailFromOrder
@orderId UNIQUEIDENTIFIER,
@dishId UNIQUEIDENTIFIER,
@branchId UNIQUEIDENTIFIER,
@quantity int
AS
BEGIN
    if not exists (select 1 from Dishes where DishId = @dishId)
    BEGIN
        RAISERROR('dish not found in db', 16,1);
        RETURN;
    END
    if not exists (select 1 from BranchDishes where DishId = @dishId and BranchId = @branchId and [Status] =  1)
    BEGIN
        RAISERROR('dish is not available in this branch', 16,1);
        RETURN;
    END
    INSERT into OrderDetail(id, [Status], Price , Quantity , DishId, OrderId)
    VALUES(NEWID(), 2 , (select CurrentPrice from Dishes where DishId = @dishId), @quantity, @dishId, @orderId)
END





GO
CREATE OR ALTER PROCEDURE getDetailReservationCards
@branchId UNIQUEIDENTIFIER,
@dateOn DATE
AS
BEGIN
    SELECT  
        r.Id AS ReservationId,
        r.CustomerId AS CustomerId,
        c.Name AS CustomerName,
        r.BranchId AS BranchId,
        b.Name AS BranchName,
        r.[Status] AS Status,
        r.DatedOn  AS DatedOn,  -- Ép kiểu DatedOn thành DATE
        td.TableNumber AS TableNumber,  -- TableNumber chỉ trả về khi có TableId
        r.TotalPeople AS TotalPeople,
        o.Total AS TotalPrice,
        o.Id AS OrderID,
        r.OrderedBy AS OrderBy,  -- Trả về OrderBy nếu có (có thể NULL)
        r.TableId AS TableId  -- Trả về TableId nếu có (có thể NULL)
    FROM Reservation r
    LEFT JOIN Customers c ON c.CustomerId = r.CustomerId 
    LEFT JOIN Branches b ON b.BranchId = r.BranchId
    LEFT JOIN TableDetail td ON td.TableId = r.TableId  -- Sử dụng LEFT JOIN để tránh việc TableNumber không tồn tại khi TableId là NULL
    LEFT JOIN Orders o ON o.ReservationId = r.Id  -- Liên kết với bảng Orders
    WHERE r.BranchId = @branchId 
    AND CAST(r.DatedOn AS DATE) = @dateOn  -- So sánh DatedOn đã được ép kiểu với @dateOn
    -- Có thể lọc thêm status nếu cần, ví dụ:
    -- AND (r.Status = 0 OR r.Status = 1)  -- Cho phép cả trạng thái đã được xử lý (1) và chưa xử lý (0)
END

GO
CREATE OR ALTER PROCEDURE UpdateReservationStatusAndDetails
    @ReservationId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER,
    @TableId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem ReservationId có tồn tại trong bảng Reservation không
    IF NOT EXISTS (SELECT 1 FROM Reservation WHERE Id = @ReservationId)
    BEGIN
        RAISERROR('Reservation not found.', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem TableId có tồn tại trong bảng TableDetail không
    IF NOT EXISTS (SELECT 1 FROM TableDetail WHERE TableId = @TableId and status  = 0)
    BEGIN
        RAISERROR('Table not found or not available', 16, 1);
        RETURN;
    END
    update TableDetail
    set [Status] = 1
    where TableId = @TableId
    -- Cập nhật Reservation với EmployeeId (OrderBy), TableId, và Status = 1 (In Progress)
    UPDATE Reservation
    SET 
        OrderedBy = @EmployeeId,      -- Cập nhật nhân viên phụ trách
        TableId = @TableId,           -- Cập nhật số bàn
        Status = 1                    -- Cập nhật trạng thái là "In Progress"
    WHERE 
        Id = @ReservationId;

    -- Trả về thông báo thành công
    SELECT 'Reservation updated successfully' AS Message;
END;


GO
CREATE OR ALTER PROCEDURE getOrderDetailsByReservationId
    @reservationId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT 
        od.Id AS OrderDishId,
        od.Price AS Price,
        od.Quantity AS Quantity,
        od.DishId AS DishId,
        d.DishName AS DishName
    FROM OrderDetail od
    JOIN Orders o ON o.Id = od.OrderId  
    JOIN Dishes d ON d.DishId = od.DishId
    WHERE o.ReservationId = @reservationId;
END


GO

create or alter proc submitSurvey
@invoiceId UNIQUEIDENTIFIER,
@point INT,
@comment NVARCHAR(100)
AS
BEGIN
     if not exists ( select 1 from Invoices where Id = @invoiceId)
    BEGIN
        RAISERROR('khong tim thay invoice', 16,1 );
        RETURN;
    END

    INSERT INTO Surveys (Id, InvoiceId, Point, Comment)
    VALUES (NEWID(), @InvoiceId, @Point, @Comment);
END

GO
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
        INSERT INTO Account (Id,CustomerId, Username, [Password], Role)
        VALUES (NEWID(),@customerId, @Email, @password, 'Customer');

        -- Nếu không có lỗi, commit transaction
        COMMIT TRANSACTION;
        PRINT 'update successfully'
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi, rollback transaction
        ROLLBACK TRANSACTION;
    END CATCH
END;





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

GO;
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


GO
CREATE OR ALTER PROCEDURE createCardForCustomer
    @CustomerId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the customer already has a card
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId)
    BEGIN
        RAISERROR('Customer already has a card.', 16, 1);
        RETURN;
    END

    -- Generate a new CardId
    DECLARE @CardId UNIQUEIDENTIFIER = NEWID();

    -- Insert the new card into the Cards table
    INSERT INTO Cards (CardId, CustomerId, EmployeeId, RankingId, StartDate, AccumulatedPoints, Valid, AccumulatedDate)
    VALUES (@CardId, @CustomerId, @EmployeeId, 1, GETDATE(), 0, 1, GETDATE());

    -- Return the new CardId
    SELECT @CardId AS CardId;
END;
GO
USE sushiDB;
GO

USE sushiDB;
GO

USE sushiDB;
GO

CREATE OR ALTER PROCEDURE getCustomersWithSingleActiveCard
    @PageNumber INT,
    @PageSize INT,
    @PhoneNumber NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH CustomerCTE AS (
        SELECT 
            c.CustomerId,
            c.Name,
            c.Phone,
            c.CitizenId,
            c.DateOfBirth,
            c.Email,
            c.Gender,
            cd.CardId,
            cd.AccumulatedPoints,
            cd.AccumulatedDate,
            cd.Valid,
            r.Name AS RankName,
            ROW_NUMBER() OVER (ORDER BY c.CustomerId) AS RowNum
        FROM Customers c
        JOIN Cards cd ON c.CustomerId = cd.CustomerId
        JOIN Rankings r ON cd.RankingId = r.Id
        WHERE cd.Valid = 1
        AND (@PhoneNumber IS NULL OR c.Phone = @PhoneNumber)
        GROUP BY c.CustomerId, c.Name, c.Phone, cd.CardId, cd.Valid, r.Name, c.CitizenId, c.Email, c.Gender, cd.CardId, cd.AccumulatedDate, cd.AccumulatedPoints, c.DateOfBirth
        HAVING COUNT(cd.CardId) = 1
    )
    SELECT *
    FROM CustomerCTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize;
END;
GO



-- PROCEDURE
GO
CREATE OR ALTER PROCEDURE PD_DISH_STATISTICS
    @branchId UNIQUEIDENTIFIER,
    @startDate DATE,
    @endDate DATE,
    @mode INT
AS
BEGIN
    -- CHECKING
    IF @endDate < @startDate
    BEGIN
        RAISERROR('ERROR: Start-Date must be greater than End-Date', 16, 1)
        RETURN;
    END
    -- READ
    -- RETURN TOP 5 BEST SALER
    IF @mode = 1
    BEGIN
        SELECT TOP 5 D.DishName, COUNT(I.Id) AS TotalOrders
        FROM Invoices I
            JOIN Orders O ON O.Id = I.OrderId
            JOIN OrderDetail OD ON OD.OrderId = O.Id
            JOIN Dishes D ON D.DishId = OD.DishId
        WHERE @startDate <= CONVERT(DATE, I.DatedOn) AND CONVERT(DATE, I.DatedOn) <= @endDate AND I.BranchId = @branchId
        GROUP BY D.DishID, D.DishName
        ORDER BY TotalOrders DESC
    END
    -- RETURN TOP 5 WORST SALER
    IF @mode = 2
    BEGIN
        SELECT TOP 5 D.DishName, COUNT(I.Id) AS TotalOrders
        FROM Invoices I
            JOIN Orders O ON O.Id = I.OrderId
            JOIN OrderDetail OD ON OD.OrderId = O.Id
            JOIN Dishes D ON D.DishId = OD.DishId
        WHERE @startDate <= CONVERT(DATE, I.DatedOn) AND CONVERT(DATE, I.DatedOn) <= @endDate AND I.BranchId = @branchId
        GROUP BY D.DishID, D.DishName
        ORDER BY TotalOrders ASC
    END
END
GO
CREATE OR ALTER PROCEDURE PD_CHANGE_EMPLOYEE_BRANCH
    @employeeID UNIQUEIDENTIFIER,
    @newBranchId UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @newStartDate DATE = CAST(GETDATE() AS DATE)
    -- A. CHECKING
    -- CHECK IF EMPLOYEE ID EXIST
    IF NOT EXISTS(
        SELECT E.Id FROM Employees E
        WHERE E.Id = @employeeID
    )
    BEGIN
        RAISERROR('ERROR: EmployeeID is wrong or not exists', 16, 1);
        RETURN;
    END
    -- CHECK IF EMPLOYEE ID STILL WORK OR NOT
    IF EXISTS(
        SELECT E.Id FROM Employees E
        WHERE E.Id = @employeeID AND E.ResignedDate IS NOT NULL
    )
    BEGIN
        RAISERROR('ERROR: Employee Resigned', 16, 1);
        RETURN;
    END
    -- CHECK IF BRANCH ID EXIST
    IF NOT EXISTS(
        SELECT B.BranchId
        FROM Branches B WHERE B.BranchId = @newBranchId
    )
    BEGIN
        RAISERROR('ERROR: BranchID not found', 16 ,1);
        RETURN;
    END
    -- CHECK IF NEW BRANCH IS OLD BRANCH OR NOT
    DECLARE @oldBranchId UNIQUEIDENTIFIER
    SELECT @oldBranchId = BranchId 
    FROM Employees E
    WHERE E.Id = @employeeID
    IF @oldBranchId = @newBranchId
    BEGIN   
        RAISERROR('ERROR: New-BranchID is the same as Old-BranchID', 16, 1);
        RETURN;
    END
    -- CHECK NEW-START-DATE MUST BE GREATER THAN OLD-START-DATE IN WORK HISTORY
    DECLARE @oldStartDate DATE
    SELECT TOP 1 @oldStartDate = WH.StartDate
    FROM WorkHistory WH
    WHERE WH.EmployeeId = @employeeID 
    ORDER BY StartDate DESC

    IF @oldStartDate > @newStartDate
    BEGIN
        RAISERROR('ERROR: New-Start-Date must be greater than old-Start-Date', 16, 1);
        RETURN;
    END
    -- SELECT @oldStartDate -- DEBUG

    -- B. UPDATING --
    -- UPDATE BranchId in Employees
    UPDATE Employees 
    SET BranchId = @newBranchId
    WHERE Id = @employeeID
    -- UPDATE WORKHISTORY, SET RESIGNDATE OF CURRENT WORKING BRANCH TO NEW START DATE
    UPDATE WorkHistory
    SET ResignDate = @newStartDate
    WHERE Id = (
        SELECT TOP 1 Id
        FROM WorkHistory
        WHERE EmployeeId = @employeeID
        ORDER BY StartDate DESC
    )
    -- INSERT INTO WORK HISTORY
    DECLARE @Id UNIQUEIDENTIFIER
    SET @Id = NEWID();

    DECLARE @currentDepartmentID UNIQUEIDENTIFIER
    SELECT @currentDepartmentID = DepartmentID
    FROM Employees E WHERE E.Id = @employeeID
    INSERT INTO WorkHistory (Id, EmployeeId, BranchId, StartDate, ResignDate, DepartmentID)
    VALUES (@Id, @employeeID, @newBranchId, @newStartDate, NULL, @currentDepartmentID)

    -- SUCCESSFULLY INSERT
    PRINT 'Employee branch updated successfully !'
END
GO





exec CreateInvoiceAndUpdateCustomerCard @


select top 1 * from Orders where Id = '1f8b0076-156e-4a7c-a0ad-35e1a2aed525'

select * from Invoices where id = '95dded23-1dec-4d2a-9286-db504fe4b67e'
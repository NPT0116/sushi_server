
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
    DECLARE @Total DECIMAL(18, 2);
    DECLARE @AfterDiscount DECIMAL(18, 2);
    DECLARE @InvoiceId UNIQUEIDENTIFIER;
    DECLARE @bonusPoint INT;
    DECLARE @Discount INT;
    DECLARE @ReservationDate DATE;  -- Biến lưu trữ ngày đặt chỗ (DatedOn từ Reservation)
    DECLARE @ReservationId UNIQUEIDENTIFIER;  -- Biến lưu trữ ReservationId
    DECLARE @TableId UNIQUEIDENTIFIER;  -- Biến lưu trữ TableId từ Reservation

    -- 1. Lấy thông tin từ bảng Orders và Reservation
    SELECT 
        @CustomerId = r.CustomerId,
        @Total = o.Total,
        @ReservationDate = r.DatedOn,  -- Lấy ngày đặt chỗ từ Reservation
        @ReservationId = r.Id,         -- Lấy ReservationId
        @TableId = r.TableId           -- Lấy TableId từ Reservation
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

    -- 5. Tạo hóa đơn mới trong bảng Invoices
    SET @InvoiceId = NEWID();  -- Tạo InvoiceId mới

    INSERT INTO Invoices (Id, OrderId, DatedOn, Total, PaymentMethod, Paid, AfterDiscount, BonusPoint)
    VALUES (@InvoiceId, @OrderId, @ReservationDate, @Total, @paymentMethod, 0, @AfterDiscount, @bonusPoint);  -- Sử dụng @ReservationDate thay vì GETDATE()

    -- 6. Cập nhật điểm số cho thẻ khách hàng
    IF EXISTS (SELECT 1 FROM Cards WHERE CustomerId = @CustomerId)
    BEGIN
        -- Cập nhật thẻ khách hàng
        UPDATE Cards
        SET AccumulatedPoints = AccumulatedPoints + @bonusPoint
        WHERE CustomerId = @CustomerId;
    END

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
    WHERE Id = @TableId;

    -- 10. Trả về thông tin hóa đơn mới tạo
    SELECT * FROM Invoices WHERE Id = @InvoiceId;
END;

GO



CREATE OR ALTER PROCEDURE GetDailyRevenueByBranch
    @BranchId UNIQUEIDENTIFIER,
    @Date DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem có tồn tại Branch với BranchId đã cho không
        IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId)
        BEGIN
            RAISERROR('BranchId does not exist.', 16, 1);
            RETURN;
        END

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

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;








go
CREATE OR ALTER PROCEDURE GetRevenueByDateRangeForBranch
    @BranchId UNIQUEIDENTIFIER,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kiểm tra xem có tồn tại Branch với BranchId đã cho không
        IF NOT EXISTS (SELECT 1 FROM Branches WHERE BranchId = @BranchId)
        BEGIN
            RAISERROR('BranchId does not exist.', 16, 1);
            RETURN;
        END

        -- Truy vấn doanh thu theo ngày cho BranchId trong khoảng thời gian từ @StartDate đến @EndDate
        SELECT 
            CAST(i.DatedOn AS DATE) AS RevenueDate,  -- Chỉ lấy ngày
            SUM(i.AfterDiscount) AS TotalRevenue
        FROM 
            Invoices i
        JOIN 
            Orders o ON o.Id = i.OrderId
        JOIN 
            Reservation r ON r.Id = o.ReservationId
        WHERE 
            i.Paid = 1  -- Hóa đơn đã thanh toán
            AND r.BranchId = @BranchId  -- Lọc theo BranchId
            AND CAST(i.DatedOn AS DATE) >= @StartDate  -- Lọc từ ngày bắt đầu
            AND CAST(i.DatedOn AS DATE) <= @EndDate  -- L
        GROUP BY 
            CAST(i.DatedOn AS DATE)  -- Nhóm theo ngày
        ORDER BY 
            RevenueDate;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
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
    Select e.Id, e.Name, e.Dob, e.Gender, e.Salary
    from Employees e 
    where (@BranchId is Null OR @BranchId = e.BranchId ) and (@DepartmentId is null or @DepartmentId = e.DepartmentId) AND
    (@Name is NULL or e.Name LIKE @Name + '%' )
    Order by Name
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT @TotalRecord = count(1) 
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



go
create or alter PROCEDURE customerSubmitReservation
@note NVARCHAR(50),
@datedOn NVARCHAR(50),
@customerId UNIQUEIDENTIFIER,
@branchId UNIQUEIDENTIFIER,
@totalPeople INT,
@id UNIQUEIDENTIFIER OUT
AS
BEGIN
    if not EXISTS (select 1 from Customers where CustomerId = @customerId)
    BEGIN
        RAISERROR('cant find customer id in db', 16,1 );
        RETURN;
    END

    if not EXISTS (select 1 from Branches where BranchId = @branchId)
    BEGIN
        RAISERROR('cant find branch id in db', 16,1 );
        RETURN;
    END
    set @id = NEWID();
    insert into Reservation (id, Note,DatedOn, CustomerId, BranchId, TotalPeople, [Status])
    VALUES(@id, @note, @datedOn, @customerId, @branchId , @totalPeople, 0)

END




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
        CAST(r.DatedOn AS DATE) AS DatedOn,  -- Ép kiểu DatedOn thành DATE
        td.TableNumber AS TableNumber,  -- TableNumber chỉ trả về khi có TableId
        r.TotalPeople AS TotalPeople,
        o.Total AS TotalPrice,
        o.Id AS OrderID,
        r.OrderedBy AS OrderBy,  -- Trả về OrderBy nếu có (có thể NULL)
        r.TableId AS TableId  -- Trả về TableId nếu có (có thể NULL)
    FROM Reservation r
    LEFT JOIN Customers c ON c.CustomerId = r.CustomerId 
    LEFT JOIN Branches b ON b.BranchId = r.BranchId
    LEFT JOIN TableDetail td ON td.Id = r.TableId  -- Sử dụng LEFT JOIN để tránh việc TableNumber không tồn tại khi TableId là NULL
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
    IF NOT EXISTS (SELECT 1 FROM TableDetail WHERE Id = @TableId and status  = 0)
    BEGIN
        RAISERROR('Table not found or not available', 16, 1);
        RETURN;
    END
    update TableDetail
    set [Status] = 1
    where Id = @TableId
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
-- index dishes
GO
CREATE NONCLUSTERED INDEX [IX_Dishes_SectionId]
    ON [dbo].[Dishes]([SectionId] ASC);


--index branchDishes
GO
CREATE NONCLUSTERED INDEX [IX_BranchDishes_BranchId]
    ON [dbo].[BranchDishes]([BranchId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_BranchDishes_DishId]
    ON [dbo].[BranchDishes]([DishId] ASC);


--index employee 

GO
CREATE NONCLUSTERED INDEX [IX_Employees_BranchId]
    ON [dbo].[Employees]([BranchId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Employees_DepartmentId]
    ON [dbo].[Employees]([DepartmentId] ASC);


--index orders

GO
CREATE NONCLUSTERED INDEX [IX_Orders_ReservationId]
    ON [dbo].[Orders]([ReservationId] ASC);


--index invoices

GO
CREATE NONCLUSTERED INDEX [IX_Invoices_OrderId]
    ON [dbo].[Invoices]([OrderId] ASC);


--survey

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Surveys_InvoiceId]
    ON [dbo].[Surveys]([InvoiceId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AccessHistories_CustomerId]
    ON [dbo].[AccessHistories]([CustomerId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_OrderDetail_OrderId]
    ON [dbo].[OrderDetail]([OrderId] ASC);
-- reservation


--index cho lấy reservationCard mỗi ngày của branch
go

CREATE NONCLUSTERED INDEX [IX_Reservation_DatedOn_BranchId]
ON [dbo].[Reservation] ([DatedOn],[BranchId])
INCLUDE ([Status],[CustomerId],[TableId],[TotalPeople])



--index cho calculate daily and range date revenue
GO
CREATE NONCLUSTERED INDEX [IDX_Invoices_Paid_BranchId_DatedOn]
ON [dbo].[Invoices] ([Paid],[BranchId],[DatedOn])
INCLUDE ([AfterDiscount])
GO

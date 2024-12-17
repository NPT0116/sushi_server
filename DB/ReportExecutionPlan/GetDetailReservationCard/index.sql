USE [sushiDB]
GO
CREATE NONCLUSTERED INDEX [IX_Reservation_DatedOn_BranchId]
ON [dbo].[Reservation] ([BranchId],[DatedOn])
INCLUDE ([Status],[OrderedBy],[CustomerId],[TableId],[TotalPeople])
GO

GO
CREATE NONCLUSTERED INDEX [IX_Orders_ReservationId]
    ON [dbo].[Orders]([ReservationId] ASC)
    INCLUDE (total)


-- no index 70ms 
-- index trên orders reservation ID: 30ms
--index trên reservation id: 14ms
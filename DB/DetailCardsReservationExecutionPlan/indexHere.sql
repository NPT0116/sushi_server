go

CREATE NONCLUSTERED INDEX [IX_Reservation_DatedOn_BranchId]
ON [dbo].[Reservation] ([DatedOn],[BranchId])
INCLUDE ([Status],[CustomerId],[TableId],[TotalPeople])

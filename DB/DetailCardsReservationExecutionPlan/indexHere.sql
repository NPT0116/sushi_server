go

CREATE NONCLUSTERED INDEX [IX_Reservation_DatedOn_BranchId]
ON [dbo].[Reservation] ([DatedOn],[BranchId])
INCLUDE ([Status],[OrderedBy],[CustomerId],[TableId],[TotalPeople])
drop index IX_Reservation_DatedOn_BranchId on reservation

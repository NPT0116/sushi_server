go

CREATE NONCLUSTERED INDEX [IX_Reservation_DatedOn_BranchId]
ON [dbo].[Reservation] ([DatedOn],[BranchId])
<<<<<<< HEAD
INCLUDE ([Status],[OrderedBy],[CustomerId],[TableId],[TotalPeople])
drop index IX_Reservation_DatedOn_BranchId on reservation
=======
INCLUDE ([Status],[CustomerId],[TableId],[TotalPeople])
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e

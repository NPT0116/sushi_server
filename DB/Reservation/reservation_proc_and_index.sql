CREATE PROCEDURE [dbo].[GetReservationsByBranchAndDate]
    @BranchId UNIQUEIDENTIFIER,
    @DatedOn DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Reservation
    WHERE BranchId = @BranchId
    AND CAST(DatedOn AS DATE) = @DatedOn;
END


CREATE NONCLUSTERED INDEX [IX_Reservation_BranchId_DatedOn]
ON [dbo].[Reservation] ([BranchId], [DatedOn]);



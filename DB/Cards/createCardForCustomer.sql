


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


EXEC createCardForCustomer @customerId =  '6d2f2f71-9cfe-40a2-a1a7-45417d5b9bd4' , @employeeId = '39b14aff-7dcb-48f6-a650-2b927250d7b5'

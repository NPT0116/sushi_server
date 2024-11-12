DECLARE @BranchId UNIQUEIDENTIFIER
DECLARE @TableCount INT = 10 -- Number of tables per branch
DECLARE @Counter INT
DECLARE @MaxPeople INT

-- Cursor to loop through each branch
DECLARE BranchCursor CURSOR FOR
SELECT BranchId FROM Branches

OPEN BranchCursor
FETCH NEXT FROM BranchCursor INTO @BranchId

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Counter = 1 -- Reset the counter for each branch

    WHILE @Counter <= @TableCount
    BEGIN
        -- Generate a random MaxPeople between 2 and 10
        SET @MaxPeople = 2 + (ABS(CHECKSUM(NEWID())) % 9)

        -- Insert a new TableDetail record for each table in this branch
        INSERT INTO TableDetail (TableId, BranchId, TableNumber, MaxPeople, Status)
        VALUES (NEWID(), @BranchId, @Counter, @MaxPeople, 0) -- Status set to false (0)

        -- Increment the counter for TableNumber
        SET @Counter = @Counter + 1
    END

    -- Move to the next branch
    FETCH NEXT FROM BranchCursor INTO @BranchId
END

-- Clean up the cursor
CLOSE BranchCursor
DEALLOCATE BranchCursor

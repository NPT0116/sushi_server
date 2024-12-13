DECLARE @StartTime DATETIME2 = SYSDATETIME();

-- Thực thi truy vấn của bạn
EXEC GetRevenueByDateRangeForBranch @BranchId = 'f490d25c-9c0b-4674-975f-53e1d1bc5366', @StartDate = '2024-1-1', @EndDate = '2024-12-30';

DECLARE @EndTime DATETIME2 = SYSDATETIME();

-- Tính toán và hiển thị thời gian thực thi
SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS ExecutionTimeMs;

-- before: 83ms
-- after: 12ms
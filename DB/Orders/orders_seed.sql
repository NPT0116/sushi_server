create or alter procedure seed_orders
as
begin
    declare @record int = (select count(*) from reservation);

    while @record > 0
    begin
		declare @reservation_id uniqueidentifier
		WITH ReservationCTE AS(
			SELECT Id, ROW_NUMBER() OVER (Order by ID) AS row_idx  FROM Reservation
		)
		SELECT @reservation_id = cte.Id  from ReservationCTE cte
		where cte.row_idx = @record

		declare @order_id uniqueidentifier = newid();

		insert into orders (Id,LastModified, status, total, ReservationId)
        values (@order_id, getdate(), 0, 0, @reservation_id);
        
        insert into OrderDetail(Id,OrderId, DishId, Price, Quantity, Status)
        select newid(), @order_id, d.DishId, d.CurrentPrice , 2,0
        from (select top(5) DishId, Dishes.CurrentPrice from dishes ORDER BY NEWID()) as d;

        set @record = @record - 1;
    end
end
go

exec seed_orders





create or alter PROC getDishesFromInvoiceId
@InvoiceId UNIQUEIDENTIFIER
as
BEGIN
    select od.DishId as DishId, d.DishName  DishName, od.Quantity as Quantity, d.CurrentPrice as Price
    from Invoices i 
    join orderDetail od on od.OrderId = i.OrderId
    join Dishes d on d.DishId = od.DishId
    where  i.Id = @InvoiceId

END

exec getDishesFromInvoiceId '13d6f48c-15e3-458e-b5ed-00003cdbafe8'
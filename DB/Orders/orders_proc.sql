-- 8 Đặt món là hợp lệ khi món đó có được phục vụ tại chi nhánh đó 

create or alter trigger trigger_submit_order_detail on OrderDetail
after insert
as
begin
    declare @total BIGINT
    set @total = (select sum(price * quantity) from inserted i)
    update orders set total = total + @total where id = (select top 1 inserted.OrderId from inserted)
end
GO
using System;

namespace sushi_server.Dto.OrderDetail;

public class OrderDetailDtoRequest
{
    public Guid DishId { get; set; }
    public int Quantity { get; set; }
}

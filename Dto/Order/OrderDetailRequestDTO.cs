using sushi_server.Models.Enum;

namespace sushi_server.Dto.Order;

public class OrderDetailRequestDTO
{
    public required Guid DishId { get; set; }
    public required long Quantity { get; set; }
}
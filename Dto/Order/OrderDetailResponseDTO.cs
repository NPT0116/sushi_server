using Dto.Dish;
using sushi_server.Models.Enum;

namespace sushi_server.Dto.Order;

public class OrderDetailResponseDTO
{
    public Guid Id { get; set; }
    public required string Status { get; set; }
    public long Price { get; set; }
    public long Quantity { get; set; }
    public DishResponseDTO Dish { get; set; }

}
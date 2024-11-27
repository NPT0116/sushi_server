
using sushi_server.Models.Enum;
namespace sushi_server.Dto.Order;

public class OrderResponseDTO
{
    public Guid Id { get; set; }
    public required DateTime LastModified {get ; set;}
    public required decimal Total { get; set; }
    public required string Status { get; set; }
    public required List<OrderDetailResponseDTO> OrderDetails { get; set; }
}
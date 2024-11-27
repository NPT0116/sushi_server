namespace sushi_server.Dto.Order;

public class OrderRequestDTO
{
    public required Guid ReservationId { get; set; }
    public required List<OrderDetailRequestDTO> OrderDetails { get; set; }
}
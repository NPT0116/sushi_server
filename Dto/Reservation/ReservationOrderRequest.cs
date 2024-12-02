using System;
using sushi_server.Dto.OrderDetail;

namespace sushi_server.Dto.Reservation;

public class ReservationOrderRequest
{
    public string Note { get; set; }
    public string DatedOn { get; set; }
    public Guid CustomerId { get; set; }
    public Guid BranchId { get; set; }
    public int TotalPeople { get; set; }
    public List<OrderDetailDtoRequest> OrderDetails { get; set; }
}

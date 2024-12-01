using System;

namespace sushi_server.Dto.Reservation;

public class UpdateReservationRequest
{
    public Guid ReservationId { get; set; }
    public Guid EmployeeId { get; set; }
    public Guid TableId { get; set; }
}


namespace Sushi_server.Dto.Reservation
{
    public class ReservationSubmitRequest
    {
        public DateTime DatedOn { get; set; }
        public string? Note { get; set; }
        public required int Status { get; set; }
        public int TotalPeople { get; set; }
        public Guid OrderedBy { get; set; }
        public Guid CustomerId { get; set; }
        public Guid BranchId { get; set; }
        public Guid TableId { get; set; }
    }
}
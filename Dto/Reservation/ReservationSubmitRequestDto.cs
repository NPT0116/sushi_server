
namespace Sushi_server.Dto.Reservation
{
    public class ReservationSubmitRequest
    {        public string DatedOn { get; set; }
        public string? Note { get; set; }
        public int Status { get; set; }
        public int TotalPeople { get; set; }
        public string OrderedBy { get; set; }
        public string CustomerId { get; set; }
        public string BranchId { get; set; }
        public string TableId { get; set; }
    }
}
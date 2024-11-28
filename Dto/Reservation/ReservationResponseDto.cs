namespace sushi_server.Dto.Reservation
{
    public class ReservationResponseDto
    {
   public Guid Id { get; set; }
    public DateTime DatedOn { get; set; }
    public string Note { get; set; }
    public int Status { get; set; }
    public int TotalPeople { get; set; }
    public string OrderedBy { get; set; }
    public Guid CustomerId { get; set; }
    public Guid BranchId { get; set; }
    public Guid TableId { get; set; }
    }
}
using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class Reservation
    {
        [Key]
        public Guid Id { get; set; }
        public DateTime DatedOn { get; set; }
        public string? Note { get; set; }
        public ReservationStatus Status { get; set; }
        public Guid? OrderedBy { get; set; }
        public Guid CustomerId { get; set; }
        public Guid BranchId { get; set; }
        public Guid TableId { get; set; }
        public int TotalPeople { get; set; }

        public required TableDetail Table { get; set; }
    }
}

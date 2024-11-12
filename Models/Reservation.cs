using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class Reservation
    {
        [Key]
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public int BranchId { get; set; }
        public DateTime DatedOn { get; set; }
        public string Note { get; set; }
        public ReservationStatus Status { get; set; }
        public int OrderedBy { get; set; }

    }
}

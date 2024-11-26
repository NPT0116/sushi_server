using sushi_server.Models.Enum;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Invoice
    {
        [Key]
        public int Id { get; set; }
        public long Total { get; set; }
        public required string PaymentMethod { get; set; } = "cash";
        public int AfterDiscount { get; set; }
        public int BonusPoint { get; set; }
        public bool Paid { get; set; }
        public DateTime DatedOn { get; set; }
        public required Order Order { get; set; }
    }
}

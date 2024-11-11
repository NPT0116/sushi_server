using sushi_server.Models.Enum;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Invoice
    {
        [Key]
        public int Id { get; set; }
        public long Total { get; set; }
        public string PaymentMethod { get; set; }
        public int AfterDiscount { get; set; }
        public int BonusPoint { get; set; }
        public InvoiceStatus Status { get; set; }
        public DateTime DatedOn { get; set; }
    }
}

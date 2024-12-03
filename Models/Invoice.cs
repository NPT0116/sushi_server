using Dto.Invoice;
using sushi_server.Models.Enum;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Invoice
    {
        [Key]
        public Guid Id { get; set; }
        public long Total { get; set; }
        public required string PaymentMethod { get; set; } = "cash";
        public int AfterDiscount { get; set; }
        public int BonusPoint { get; set; }
        public bool Paid { get; set; }
        public DateTime DatedOn { get; set; }
        public Guid OrderId { get; set; }
        public Order? Order { get; set; }
        public Survey? Survey { get; set; }
        public InvoiceResponseDTO toInvoiceResponseDTO()
        {
            return new InvoiceResponseDTO
            {
                Id = this.Id,
                Total = this.Total,
                PaymentMethod = this.PaymentMethod,
                AfterDiscount = this.AfterDiscount,
                BonusPoint = this.BonusPoint,
                Paid = this.Paid.ToString(),
                DatedOn = this.DatedOn,
                Order = this.Order.ToResponseDTO(),
            };
        }
    }
}

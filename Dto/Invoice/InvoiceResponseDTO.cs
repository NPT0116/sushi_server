using System.ComponentModel.DataAnnotations;
using sushi_server.Dto.Order;

namespace Dto.Invoice;

public class InvoiceResponseDTO
{
    public Guid Id { get; set; }
    public long Total { get; set; }
    public required string PaymentMethod { get; set; } = "cash";
    public long AfterDiscount { get; set; }
    public int BonusPoint { get; set; }
    public required string Paid { get; set; }
    public DateTime DatedOn { get; set; }
    public OrderResponseDTO Order { get; set; }
}
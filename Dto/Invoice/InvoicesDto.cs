using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.Invoice
{
    public class InvoicesDto
    {
    public Guid Id { get; set; }

    public long? Total { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public long? AfterDiscount { get; set; }

    public int BonusPoint { get; set; }

    public bool Paid { get; set; }

    public DateTime DatedOn { get; set; }

    public Guid OrderId { get; set; }

    public Guid BranchId { get; set; }
    }
}
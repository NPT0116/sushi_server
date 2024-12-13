using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Invoice
{
    public Guid Id { get; set; }

    public long Total { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public int AfterDiscount { get; set; }

    public int BonusPoint { get; set; }

    public bool Paid { get; set; }

    public DateTime DatedOn { get; set; }

    public Guid OrderId { get; set; }

    public Guid BranchId { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Order Order { get; set; } = null!;

    public virtual ICollection<Survey> Surveys { get; set; } = new List<Survey>();
}

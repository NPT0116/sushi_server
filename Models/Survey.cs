using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Survey
{
    public Guid Id { get; set; }

    public Guid InvoiceId { get; set; }

    public int Point { get; set; }

    public string Comment { get; set; } = null!;

    public virtual Invoice Invoice { get; set; } = null!;
}

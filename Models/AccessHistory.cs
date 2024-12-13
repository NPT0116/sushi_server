using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class AccessHistory
{
    public Guid Id { get; set; }

    public Guid CustomerId { get; set; }

    public DateTime AccessTime { get; set; }

    public int Duration { get; set; }

    public virtual Customer Customer { get; set; } = null!;
}

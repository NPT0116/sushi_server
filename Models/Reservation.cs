using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Reservation
{
    public Guid Id { get; set; }

    public DateTime DatedOn { get; set; }

    public string? Note { get; set; }

    public int Status { get; set; }

    public Guid? OrderedBy { get; set; }

    public Guid CustomerId { get; set; }

    public Guid BranchId { get; set; }

    public Guid? TableId { get; set; }

    public int TotalPeople { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Employee? OrderedByNavigation { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual TableDetail? Table { get; set; }
}

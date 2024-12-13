using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class TableDetail
{
    public Guid TableId { get; set; }

    public Guid BranchId { get; set; }

    public int TableNumber { get; set; }

    public int MaxPeople { get; set; }

    public bool Status { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}

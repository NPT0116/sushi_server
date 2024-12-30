using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Card
{
    public DateTime StartDate { get; set; }

    public float AccumulatedPoints { get; set; }

    public bool Valid { get; set; }

    public DateTime? AccumulatedDate { get; set; }

    public Guid EmployeeId { get; set; }

    public int RankingId { get; set; }

    public Guid CustomerId { get; set; }

    public Guid CardId { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual Employee Employee { get; set; } = null!;

    public virtual Ranking Ranking { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Ranking
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int RequirePoint { get; set; }

    public int Discount { get; set; }

    public int UpgradePoint { get; set; }

    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

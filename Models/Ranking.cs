using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class Ranking
{
    [Key]
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int RequirePoint { get; set; }

    public int Discount { get; set; }

    public int UpgradePoint { get; set; }

    [InverseProperty("Ranking")]
    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Ranking
{
<<<<<<< HEAD
    [Key]
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int RequirePoint { get; set; }

    public int Discount { get; set; }

    public int UpgradePoint { get; set; }

    [InverseProperty("Ranking")]
=======
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int RequirePoint { get; set; }

    public int Discount { get; set; }

    public int UpgradePoint { get; set; }

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

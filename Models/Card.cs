using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Card
{
    public DateTime StartDate { get; set; }
<<<<<<< HEAD

    public float AccumulatedPoints { get; set; }

    public bool Valid { get; set; }

    public DateTime? AccumulatedDate { get; set; }

    public Guid EmployeeId { get; set; }

    public int RankingId { get; set; }

    public Guid CustomerId { get; set; }

    [Key]
    public Guid CardId { get; set; }

    [ForeignKey("CustomerId")]
    [InverseProperty("Cards")]
    public virtual Customer Customer { get; set; } = null!;

    [ForeignKey("EmployeeId")]
    [InverseProperty("Cards")]
    public virtual Employee Employee { get; set; } = null!;

    [ForeignKey("RankingId")]
    [InverseProperty("Cards")]
=======

    public float AccumulatedPoints { get; set; }

    public bool Valid { get; set; }

    public DateTime? AccumulatedDate { get; set; }

    public Guid EmployeeId { get; set; }

    public int RankingId { get; set; }

    public Guid CustomerId { get; set; }

    public Guid CardId { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual Employee Employee { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Ranking Ranking { get; set; } = null!;
}

using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("TableDetail")]
public partial class TableDetail
{
    [Key]
    public Guid TableId { get; set; }

    public Guid BranchId { get; set; }

    public int TableNumber { get; set; }

    public int MaxPeople { get; set; }

    public bool Status { get; set; }

    [ForeignKey("BranchId")]
    [InverseProperty("TableDetails")]
    public virtual Branch Branch { get; set; } = null!;

    [InverseProperty("Table")]
=======

namespace sushi_server.Models;

public partial class TableDetail
{
    public Guid TableId { get; set; }

    public Guid BranchId { get; set; }

    public int TableNumber { get; set; }

    public int MaxPeople { get; set; }

    public bool Status { get; set; }

    public virtual Branch Branch { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}

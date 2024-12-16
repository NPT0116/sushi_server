using System;
using System.Collections.Generic;
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
    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}

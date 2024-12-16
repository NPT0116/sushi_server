using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("Reservation")]
[Index("DatedOn", "BranchId", Name = "IX_Reservation_DatedOn_BranchId")]
public partial class Reservation
{
    [Key]
    public Guid Id { get; set; }

    public DateTime DatedOn { get; set; }

    public string? Note { get; set; }

    public int Status { get; set; }

    public Guid? OrderedBy { get; set; }

    public Guid CustomerId { get; set; }

    public Guid BranchId { get; set; }

    public Guid? TableId { get; set; }

    public int TotalPeople { get; set; }

    [ForeignKey("BranchId")]
    [InverseProperty("Reservations")]
    public virtual Branch Branch { get; set; } = null!;

    [InverseProperty("Reservation")]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    [ForeignKey("TableId")]
    [InverseProperty("Reservations")]
    public virtual TableDetail? Table { get; set; }
=======

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

    public Guid TableId { get; set; }

    public int TotalPeople { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual TableDetail Table { get; set; } = null!;
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
}

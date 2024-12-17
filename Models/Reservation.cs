using System;
using System.Collections.Generic;
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
}

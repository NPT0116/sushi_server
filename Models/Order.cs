using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("ReservationId", Name = "IX_Orders_ReservationId")]
public partial class Order
{
    [Key]
    public Guid Id { get; set; }

    public long Total { get; set; }

    public DateTime LastModified { get; set; }

    public int Status { get; set; }

    public Guid? ReservationId { get; set; }

    [InverseProperty("Order")]
    public virtual ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();

    [InverseProperty("Order")]
    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    [ForeignKey("ReservationId")]
    [InverseProperty("Orders")]
=======

namespace sushi_server.Models;

public partial class Order
{
    public Guid Id { get; set; }

    public long Total { get; set; }

    public DateTime LastModified { get; set; }

    public int Status { get; set; }

    public Guid? ReservationId { get; set; }

    public virtual ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Reservation? Reservation { get; set; }
}

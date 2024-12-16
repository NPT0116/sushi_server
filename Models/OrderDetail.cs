using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("OrderDetail")]
[Index("OrderId", Name = "IX_OrderDetail_OrderId")]
public partial class OrderDetail
{
    [Key]
    public Guid Id { get; set; }

    public int Status { get; set; }

    public long Price { get; set; }

    public long Quantity { get; set; }

    public Guid DishId { get; set; }

    public Guid OrderId { get; set; }

    [ForeignKey("OrderId")]
    [InverseProperty("OrderDetails")]
=======

namespace sushi_server.Models;

public partial class OrderDetail
{
    public Guid Id { get; set; }

    public int Status { get; set; }

    public long Price { get; set; }

    public long Quantity { get; set; }

    public Guid DishId { get; set; }

    public Guid OrderId { get; set; }

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Order Order { get; set; } = null!;
}

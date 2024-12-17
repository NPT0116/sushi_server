using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("BranchId", Name = "IX_BranchDishes_BranchId")]
[Index("DishId", Name = "IX_BranchDishes_DishId")]
public partial class BranchDish
{
    [Key]
    public Guid BranchDishId { get; set; }

    public Guid BranchId { get; set; }

    public Guid DishId { get; set; }

    public bool Status { get; set; }

    public bool ShipStatus { get; set; }

    [ForeignKey("BranchId")]
    [InverseProperty("BranchDishes")]
    public virtual Branch Branch { get; set; } = null!;

    [ForeignKey("DishId")]
    [InverseProperty("BranchDishes")]
    public virtual Dish Dish { get; set; } = null!;
}

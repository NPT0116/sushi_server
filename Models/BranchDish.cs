using System;
using System.Collections.Generic;
<<<<<<< HEAD
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
=======

namespace sushi_server.Models;

public partial class BranchDish
{
    public Guid BranchDishId { get; set; }

    public Guid BranchId { get; set; }

    public Guid DishId { get; set; }

    public bool Status { get; set; }

    public bool ShipStatus { get; set; }

    public virtual Branch Branch { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Dish Dish { get; set; } = null!;
}

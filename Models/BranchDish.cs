using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class BranchDish
{
    public Guid BranchDishId { get; set; }

    public Guid BranchId { get; set; }

    public Guid DishId { get; set; }

    public bool Status { get; set; }

    public bool ShipStatus { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Dish Dish { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Dish
{
    public Guid DishId { get; set; }

    public string DishName { get; set; } = null!;

    public int CurrentPrice { get; set; }

    public Guid SectionId { get; set; }

    public virtual ICollection<BranchDish> BranchDishes { get; set; } = new List<BranchDish>();

    public virtual Section Section { get; set; } = null!;
}

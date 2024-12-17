using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("SectionId", Name = "IX_Dishes_SectionId")]
public partial class Dish
{
    [Key]
    public Guid DishId { get; set; }

    public string DishName { get; set; } = null!;

    public int CurrentPrice { get; set; }

    public Guid SectionId { get; set; }

    [InverseProperty("Dish")]
    public virtual ICollection<BranchDish> BranchDishes { get; set; } = new List<BranchDish>();

    [ForeignKey("SectionId")]
    [InverseProperty("Dishes")]
    public virtual Section Section { get; set; } = null!;
}

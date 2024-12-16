using System;
using System.Collections.Generic;
<<<<<<< HEAD
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
=======

namespace sushi_server.Models;

public partial class Dish
{
    public Guid DishId { get; set; }

    public string DishName { get; set; } = null!;

    public int CurrentPrice { get; set; }

    public Guid SectionId { get; set; }

    public virtual ICollection<BranchDish> BranchDishes { get; set; } = new List<BranchDish>();

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Section Section { get; set; } = null!;
}

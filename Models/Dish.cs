using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace sushi_server.Models;

public class Dish
{
    [Key]
    public Guid DishId { get; set; }
    [Required]
    public string DishName { get; set; } = string.Empty;
    [Required]
    public int CurrentPrice { get; set; } 
    public Guid SectionId { get; set; }
    [ForeignKey("SectionId")]
    public Section Section { get; set; } = null!;


}

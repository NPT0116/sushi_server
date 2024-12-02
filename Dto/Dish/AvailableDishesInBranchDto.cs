using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Dish;

public class AvailableDishesInBranchDto
{
    [Key]
    public Guid DishId { get; set; }
    [Required]
    public string DishName { get; set; } = string.Empty;
    [Required]
    public int CurrentPrice { get; set; }
    public Guid SectionId { get; set; }

}

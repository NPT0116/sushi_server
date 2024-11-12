using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Dish;

public class GetAllDishDto
{
    public Guid DishId { get; set; }
    [Required]
    public string DishName { get; set; } = string.Empty;
    [Required]
    public int CurrentPrice { get; set; } 
}

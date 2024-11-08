using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Dish;

public class GetDishesBySectionIdDto
{
    [Required]
    public string DishName { get; set; } = string.Empty;
    [Required]
    public int CurrentPrice { get; set; } 
    [Required]
    public Guid SectionId { get; set; }
}

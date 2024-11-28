using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Dto.Dish;

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
    public List<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public DishResponseDTO toResponseDTO() {
        return new DishResponseDTO {
            DishId = this.DishId,
            DishName = this.DishName,
            CurrentPrice = this.CurrentPrice
        };
    }
}

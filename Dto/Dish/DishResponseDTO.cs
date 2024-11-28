
namespace Dto.Dish;

public class DishResponseDTO
{
    public Guid DishId { get; set; }
    public string DishName { get; set; } = string.Empty;
    public int CurrentPrice { get; set; }
}
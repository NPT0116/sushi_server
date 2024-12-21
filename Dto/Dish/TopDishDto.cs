using System;

namespace sushi_server.Dto.Dish;

public class TopDishDto
{

    public string DishName { get; set; } = null!;
    public int TotalOrders { get; set; }
}

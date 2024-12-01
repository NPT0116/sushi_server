using System;

namespace sushi_server.Dto.BranchDishes;

public class BranchDishesDto
{
    public Guid BranchId { get; set; }

    public Guid DishId { get; set; }

    public bool Status { get; set; }
    public bool ShipStatus { get; set; }
}

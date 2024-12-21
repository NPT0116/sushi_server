using System;

namespace sushi_server.Dto.Dish;

public class TopDishBodyRequestDto
{
    public Guid BranchId { get; set; }
    public DateOnly StartDate { get; set; }
    public DateOnly EndDate { get; set; }

}

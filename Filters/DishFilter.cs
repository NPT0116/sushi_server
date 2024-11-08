using System;

namespace sushi_server.Filters;

public class DishFilter
{
    public string? DishName { get; set; }
    public int? MinPrice { get; set; }
    public int? MaxPrice { get; set; }
}

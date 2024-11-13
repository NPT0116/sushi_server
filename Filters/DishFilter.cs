using System;

namespace sushi_server.Filters;

public class DishFilter
{
    public string? DishName { get; set; }
    public int? MinPrice { get; set; }
    public int? MaxPrice { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public Guid? SectionId { get; set; }
    public Guid? BranchId { get; set; }
}

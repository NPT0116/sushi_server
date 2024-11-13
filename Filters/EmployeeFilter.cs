using System;

namespace sushi_server.Filters;

public class EmployeeFilter
{
    public Guid? BranchId { get; set; }
    public Guid? DepartmentId { get; set; }
    public string Name { get; set; } = string.Empty;
}

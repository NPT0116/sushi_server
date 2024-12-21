using System;

namespace sushi_server.Department;

public class DepartmentDto
{
    public Guid DepartmentId { get; set; }

    public string DepartmentName { get; set; } = null!;

    public int BaseSalary { get; set; }
}

using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Department
{
    public Guid DepartmentId { get; set; }

    public string DepartmentName { get; set; } = null!;

    public int BaseSalary { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

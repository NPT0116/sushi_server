using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class WorkHistory
{
    public Guid Id { get; set; }

    public Guid EmployeeId { get; set; }

    public Guid BranchId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly? ResignDate { get; set; }

    public Guid DepartmentId { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Department Department { get; set; } = null!;

    public virtual Employee Employee { get; set; } = null!;
}

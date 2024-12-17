using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("WorkHistory")]
public partial class WorkHistory
{
    [Key]
    public Guid Id { get; set; }

    public Guid EmployeeId { get; set; }

    public Guid BranchId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly ResignDate { get; set; }

    public Guid DepartmentId { get; set; }

    [ForeignKey("BranchId")]
    [InverseProperty("WorkHistories")]
    public virtual Branch Branch { get; set; } = null!;

    [ForeignKey("DepartmentId")]
    [InverseProperty("WorkHistories")]
    public virtual Department Department { get; set; } = null!;

    [ForeignKey("EmployeeId")]
    [InverseProperty("WorkHistories")]
    public virtual Employee Employee { get; set; } = null!;
}

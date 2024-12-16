using System;
using System.Collections.Generic;
<<<<<<< HEAD
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
=======

namespace sushi_server.Models;

public partial class WorkHistory
{
    public Guid Id { get; set; }

    public Guid EmployeeId { get; set; }

    public Guid BranchId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly ResignDate { get; set; }

    public Guid DepartmentId { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Department Department { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Employee Employee { get; set; } = null!;
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class Department
{
    [Key]
    public Guid DepartmentId { get; set; }

    public string DepartmentName { get; set; } = null!;

    public int BaseSalary { get; set; }

    [InverseProperty("Department")]
    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    [InverseProperty("Department")]
    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Department
{
<<<<<<< HEAD
    [Key]
    public Guid DepartmentId { get; set; }

    public string DepartmentName { get; set; } = null!;

    public int BaseSalary { get; set; }

    [InverseProperty("Department")]
    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    [InverseProperty("Department")]
=======
    public Guid DepartmentId { get; set; }

    public string DepartmentName { get; set; } = null!;

    public int BaseSalary { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

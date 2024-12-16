﻿using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("BranchId", Name = "IX_Employees_BranchId")]
[Index("DepartmentId", Name = "IX_Employees_DepartmentId")]
public partial class Employee
{
    [Key]
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public DateTime Dob { get; set; }

    public string Gender { get; set; } = null!;

    public int Salary { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime? ResignedDate { get; set; }

    public Guid DepartmentId { get; set; }

    public Guid BranchId { get; set; }

    [InverseProperty("Employee")]
    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();

    [ForeignKey("BranchId")]
    [InverseProperty("Employees")]
    public virtual Branch Branch { get; set; } = null!;

    [InverseProperty("Manager")]
    public virtual ICollection<Branch> Branches { get; set; } = new List<Branch>();

    [InverseProperty("Employee")]
    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();

    [ForeignKey("DepartmentId")]
    [InverseProperty("Employees")]
    public virtual Department Department { get; set; } = null!;

    [InverseProperty("Employee")]
=======

namespace sushi_server.Models;

public partial class Employee
{
    public Guid Id { get; set; }

    public string Name { get; set; } = null!;

    public DateTime Dob { get; set; }

    public string Gender { get; set; } = null!;

    public int Salary { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime? ResignedDate { get; set; }

    public Guid DepartmentId { get; set; }

    public Guid BranchId { get; set; }

    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();

    public virtual Branch Branch { get; set; } = null!;

    public virtual ICollection<Branch> Branches { get; set; } = new List<Branch>();

    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();

    public virtual Department Department { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

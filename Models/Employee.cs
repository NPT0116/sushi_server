using System;
using System.Collections.Generic;

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

    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

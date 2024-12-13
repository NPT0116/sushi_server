using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Branch
{
    public Guid BranchId { get; set; }

    public Guid? ManagerId { get; set; }

    public string Name { get; set; } = null!;

    public string Address { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public TimeOnly OpeningTime { get; set; }

    public TimeOnly ClosingTime { get; set; }

    public bool CarParking { get; set; }

    public bool MotorParking { get; set; }

    public bool Ship { get; set; }

    public int TotalTable { get; set; }

    public virtual ICollection<BranchDish> BranchDishes { get; set; } = new List<BranchDish>();

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();

    public virtual Employee? Manager { get; set; }

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();

    public virtual ICollection<TableDetail> TableDetails { get; set; } = new List<TableDetail>();

    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

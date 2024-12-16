using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Branch
{
<<<<<<< HEAD
    [Key]
    public Guid BranchId { get; set; }

    public Guid? ManagerId { get; set; }

    [StringLength(100)]
    public string Name { get; set; } = null!;

    [StringLength(200)]
    public string Address { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public TimeOnly OpeningTime { get; set; }

    public TimeOnly ClosingTime { get; set; }

    public bool CarParking { get; set; }

    public bool MotorParking { get; set; }

    public bool Ship { get; set; }

    public int TotalTable { get; set; }

    [InverseProperty("Branch")]
    public virtual ICollection<BranchDish> BranchDishes { get; set; } = new List<BranchDish>();

    [InverseProperty("Branch")]
    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    [InverseProperty("Branch")]
    public virtual ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();

    [ForeignKey("ManagerId")]
    [InverseProperty("Branches")]
    public virtual Employee? Manager { get; set; }

    [InverseProperty("Branch")]
    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();

    [InverseProperty("Branch")]
    public virtual ICollection<TableDetail> TableDetails { get; set; } = new List<TableDetail>();

    [InverseProperty("Branch")]
=======
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

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

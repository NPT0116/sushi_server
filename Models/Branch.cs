﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class Branch
{
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
    public virtual ICollection<WorkHistory> WorkHistories { get; set; } = new List<WorkHistory>();
}

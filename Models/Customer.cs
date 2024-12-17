using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class Customer
{
    [Key]
    public Guid CustomerId { get; set; }

    [StringLength(100)]
    public string Name { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public int Gender { get; set; }

    [StringLength(20)]
    public string CitizenId { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    [InverseProperty("Customer")]
    public virtual ICollection<AccessHistory> AccessHistories { get; set; } = new List<AccessHistory>();

    [InverseProperty("Customer")]
    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();

    [InverseProperty("Customer")]
    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

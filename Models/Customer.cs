using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Customer
{
<<<<<<< HEAD
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
=======
    public Guid CustomerId { get; set; }

    public string Name { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public int Gender { get; set; }

    public string CitizenId { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public virtual ICollection<AccessHistory> AccessHistories { get; set; } = new List<AccessHistory>();

    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

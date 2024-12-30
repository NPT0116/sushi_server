using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Customer
{
    public Guid CustomerId { get; set; }

    public string Name { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public int Gender { get; set; }

    public string CitizenId { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public virtual ICollection<AccessHistory> AccessHistories { get; set; } = new List<AccessHistory>();

    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();

    public virtual ICollection<Card> Cards { get; set; } = new List<Card>();
}

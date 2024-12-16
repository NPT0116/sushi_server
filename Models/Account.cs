using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("Account")]
[Index("Username", Name = "UQ__Account__536C85E480C014EE", IsUnique = true)]
public partial class Account
{
    [Key]
    public Guid Id { get; set; }

    public Guid? CustomerId { get; set; }

    public Guid? EmployeeId { get; set; }

    [StringLength(50)]
    [Unicode(false)]
    public string Username { get; set; } = null!;

    [StringLength(20)]
    [Unicode(false)]
    public string Password { get; set; } = null!;

    [StringLength(10)]
    [Unicode(false)]
    public string Role { get; set; } = null!;

    [ForeignKey("CustomerId")]
    [InverseProperty("Accounts")]
    public virtual Customer? Customer { get; set; }

    [ForeignKey("EmployeeId")]
    [InverseProperty("Accounts")]
=======

namespace sushi_server.Models;

public partial class Account
{
    public Guid Id { get; set; }

    public Guid? CustomerId { get; set; }

    public Guid? EmployeeId { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public bool IsEmployee { get; set; }

    public virtual Customer? Customer { get; set; }

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Employee? Employee { get; set; }
}

using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("CustomerId", Name = "IX_AccessHistories_CustomerId")]
public partial class AccessHistory
{
    [Key]
    public Guid Id { get; set; }

    public Guid CustomerId { get; set; }

    public DateTime AccessTime { get; set; }

    public int Duration { get; set; }

    [ForeignKey("CustomerId")]
    [InverseProperty("AccessHistories")]
=======

namespace sushi_server.Models;

public partial class AccessHistory
{
    public Guid Id { get; set; }

    public Guid CustomerId { get; set; }

    public DateTime AccessTime { get; set; }

    public int Duration { get; set; }

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Customer Customer { get; set; } = null!;
}

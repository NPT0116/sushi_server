using System;
using System.Collections.Generic;
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
    public virtual Customer Customer { get; set; } = null!;
}

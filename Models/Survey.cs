using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("InvoiceId", Name = "IX_Surveys_InvoiceId", IsUnique = true)]
public partial class Survey
{
    [Key]
    public Guid Id { get; set; }

    public Guid InvoiceId { get; set; }

    public int Point { get; set; }

    public string Comment { get; set; } = null!;

    [ForeignKey("InvoiceId")]
    [InverseProperty("Survey")]
=======

namespace sushi_server.Models;

public partial class Survey
{
    public Guid Id { get; set; }

    public Guid InvoiceId { get; set; }

    public int Point { get; set; }

    public string Comment { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Invoice Invoice { get; set; } = null!;
}

using System;
using System.Collections.Generic;
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
    public virtual Invoice Invoice { get; set; } = null!;
}

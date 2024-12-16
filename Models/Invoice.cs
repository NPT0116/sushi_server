using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Index("Paid", "BranchId", "DatedOn", Name = "IDX_Invoices_Paid_BranchId_DatedOn")]
[Index("OrderId", Name = "IX_Invoices_OrderId")]
public partial class Invoice
{
    [Key]
    public Guid Id { get; set; }

    public long Total { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public int AfterDiscount { get; set; }

    public int BonusPoint { get; set; }

    public bool Paid { get; set; }

    public DateTime DatedOn { get; set; }

    public Guid OrderId { get; set; }

    public Guid BranchId { get; set; }

    [ForeignKey("BranchId")]
    [InverseProperty("Invoices")]
    public virtual Branch Branch { get; set; } = null!;

    [ForeignKey("OrderId")]
    [InverseProperty("Invoices")]
    public virtual Order Order { get; set; } = null!;

    [InverseProperty("Invoice")]
=======

namespace sushi_server.Models;

public partial class Invoice
{
    public Guid Id { get; set; }

    public long Total { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public int AfterDiscount { get; set; }

    public int BonusPoint { get; set; }

    public bool Paid { get; set; }

    public DateTime DatedOn { get; set; }

    public Guid OrderId { get; set; }

    public Guid BranchId { get; set; }

    public virtual Branch Branch { get; set; } = null!;

    public virtual Order Order { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual Survey? Survey { get; set; }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Numerics;
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

    public long AfterDiscount { get; set; }

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
    public virtual Survey? Survey { get; set; }
}

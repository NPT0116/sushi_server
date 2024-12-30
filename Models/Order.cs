using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Order
{
    public Guid Id { get; set; }

    public long Total { get; set; }

    public DateTime LastModified { get; set; }

    public int Status { get; set; }

    public Guid? ReservationId { get; set; }

    public DateOnly? DatedOn { get; set; }

    public virtual ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();

    public virtual ICollection<Invoices_Partition_2> Invoices_Partition_2s { get; set; } = new List<Invoices_Partition_2>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual Reservation? Reservation { get; set; }
}

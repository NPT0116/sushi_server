using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class OrderDetail
{
    public Guid Id { get; set; }

    public int Status { get; set; }

    public long Price { get; set; }

    public long Quantity { get; set; }

    public Guid DishId { get; set; }

    public Guid OrderId { get; set; }

    public virtual Order Order { get; set; } = null!;
}

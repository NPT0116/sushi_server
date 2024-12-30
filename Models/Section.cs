using System;
using System.Collections.Generic;

namespace sushi_server.Models;

public partial class Section
{
    public Guid SectionId { get; set; }

    public string SectionName { get; set; } = null!;

    public virtual ICollection<Dish> Dishes { get; set; } = new List<Dish>();
}

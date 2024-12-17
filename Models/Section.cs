using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class Section
{
    [Key]
    public Guid SectionId { get; set; }

    public string SectionName { get; set; } = null!;

    [InverseProperty("Section")]
    public virtual ICollection<Dish> Dishes { get; set; } = new List<Dish>();
}

using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

=======

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
namespace sushi_server.Models;

public partial class Section
{
<<<<<<< HEAD
    [Key]
    public Guid SectionId { get; set; }

    public string SectionName { get; set; } = null!;

    [InverseProperty("Section")]
=======
    public Guid SectionId { get; set; }

    public string SectionName { get; set; } = null!;

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public virtual ICollection<Dish> Dishes { get; set; } = new List<Dish>();
}

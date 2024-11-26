using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public class Section
{
    [Key]
    public Guid SectionId { get; set; }
    [Required]
    public string SectionName { get; set; } = string.Empty;

    public ICollection<Dish> Dishes { get; set; } = [];
}

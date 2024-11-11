using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace sushi_server.Models;

public class TableDetail
{
    [Key]
    public Guid TableId { get; set; }
    [Required]
    public Guid BranchId { get; set; }
    public Branch? Branch { get; set; }
    [Required]
    public int TableNumber { get; set; }
    [Required]
    public int MaxPeople { get; set; }
    [Required]
    public bool  Status { get; set; }


}

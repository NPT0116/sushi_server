using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using sushi_server.Models.Enum;

namespace sushi_server.Models;

public class TableDetail
{
    [Key]
    public Guid Id { get; set; }
    public int TableNumber { get; set; }
    public long MaxCapacity { get; set; }
    public TableStatus Status { get; set; }
    public Guid BranchId { get; set; }

    // Navigation properties
    public required ICollection<Reservation> Reservations { get; set; }


}

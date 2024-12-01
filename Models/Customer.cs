using System;
using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;

namespace sushi_server.Models;

public class Customer
{
    [Key]
    public Guid CustomerId { get; set; }
    [Required]
    [MaxLength(100, ErrorMessage = "Name can't exceed 100 character")]
    public string Name { get; set; } = string.Empty;
    public DateTime? DateOfBirth { get; set; }
    public Gender Gender { get; set; }
    [Required]
    [MaxLength(20, ErrorMessage = "CitizenId can't exceed 100 character")]
    public string CitizenId { get; set; } = string.Empty;
    [Required]
    [Phone]
    public string Phone { get; set; } = string.Empty;
    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;
}

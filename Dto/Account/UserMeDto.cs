using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Account;

public class UserMeDto
{
    public Guid AccountId { get; set; }
    public Guid CustomerId { get; set; }
    [Required]
    public string UserName { get; set; } = string.Empty;
    [Required]
    public string Name { get; set; } = string.Empty;
    [Phone]
    public string Phone { get; set; } = string.Empty;
}

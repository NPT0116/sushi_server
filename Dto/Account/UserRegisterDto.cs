using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Account;

public class UserRegisterDto
{
    [Required] 
    public string? UserName { get; set; }
    [Required]
    public string? Password { get; set; }
}

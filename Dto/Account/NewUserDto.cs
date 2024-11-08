using System;

namespace sushi_server.Dto.Account;

public class NewUserDto
{
    public string  UserName { get; set; } = string.Empty;
    public string Token { get; set; } = string.Empty;
}

using System;
using sushi_server.Models;

namespace sushi_server.Interfaces;

public interface ITokenService
{
    public string CreateToken(AppUser appUser);
}

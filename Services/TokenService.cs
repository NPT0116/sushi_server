using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using sushi_server.Interfaces;
using sushi_server.Models;

namespace sushi_server.Services;

public class TokenService : ITokenService
{
    private readonly IConfiguration _config;
    private readonly SymmetricSecurityKey _key;
    public TokenService(IConfiguration config)
    {
        _config = config;
        _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["JwtSettings:SigningKey"]));
    }
    public string CreateToken(Account appUser)
    {
        var claims = new List<Claim>
        {
            new Claim(JwtRegisteredClaimNames.UniqueName, appUser.Username),
            new Claim(ClaimTypes.NameIdentifier, appUser.CustomerId.ToString()),  // Add CustomerId as a claim (if needed)
            new Claim(ClaimTypes.Role, appUser.IsEmployee ? "Employee" : "Customer") // Add role depending on IsEmployee flag

        };
        // hashed sigining key
        var creds = new SigningCredentials(_key, SecurityAlgorithms.HmacSha512Signature);
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            // expires sau 2 tieng
            Expires = DateTime.Now.AddHours(2),
            SigningCredentials = creds,
            Issuer = _config["JwtSettings:Issuer"],
            Audience = _config["JwtSettings:Audience"]
        };
        var tokenHandler = new JwtSecurityTokenHandler();
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }
}

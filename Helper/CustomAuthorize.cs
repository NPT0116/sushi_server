using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace sushi_server.Helper
{
    public class CustomAuthorize : Attribute, IAuthorizationFilter
    {
        private readonly string _requiredRole;

        // Constructor to specify the required role (optional)
        public CustomAuthorize(string requiredRole = null)
        {
            _requiredRole = requiredRole;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            // Get IConfiguration from the HttpContext's service provider
            var configuration = context.HttpContext.RequestServices.GetService<IConfiguration>();

            // Extract the authorization token from the header
            var authorizationHeader = context.HttpContext.Request.Headers["Authorization"];
            var authorizationHeaderValue = authorizationHeader.ToString();

            // Check if the header exists and starts with "Bearer"
            if (string.IsNullOrEmpty(authorizationHeaderValue) || !authorizationHeaderValue.StartsWith("Bearer "))
            {
                context.Result = new UnauthorizedResult();
                return;
            }

            var token = authorizationHeaderValue.Substring("Bearer ".Length).Trim();
            Console.WriteLine(token);
            if (string.IsNullOrEmpty(token))
            {
                context.Result = new UnauthorizedResult();
                return;
            }

            try
            {
                // Retrieve JWT settings from configuration
                var secretKey = configuration["JwtSettings:SigningKey"];
                var issuer = configuration["JwtSettings:Issuer"];
                var audience = configuration["JwtSettings:Audience"];

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(secretKey); // Use secret key from appsettings.json

                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero, // No tolerance for expired tokens
                    ValidIssuer = issuer, // From appsettings.json
                    ValidAudience = audience, // From appsettings.json
                    IssuerSigningKey = new SymmetricSecurityKey(key)
                };

                var principal = tokenHandler.ValidateToken(token, validationParameters, out var validatedToken);

                // Optional: Check if the user has the required role
                if (!string.IsNullOrEmpty(_requiredRole))
                {
                    var roleClaim = principal.FindFirst(ClaimTypes.Role)?.Value;

                    if (roleClaim != _requiredRole)
                    {
                        context.Result = new ForbidResult(); // If the role doesn't match
                        return;
                    }
                }

                // Attach the claims to the HttpContext if needed (optional)
                context.HttpContext.User = principal;
            }
            catch (Exception)
            {
                context.Result = new UnauthorizedResult(); // Token is invalid or expired
                return;
            }
        }
    }
}

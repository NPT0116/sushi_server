using System.IdentityModel.Tokens.Jwt;
using Azure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

using sushi_server.Dto.Account;
using sushi_server.Dto.Employee;
using sushi_server.Helper;
using sushi_server.Interfaces;
using sushi_server.Models;
using System.Text.RegularExpressions;

namespace sushi_server.Controllers
{
    [Route("api/account")]
    [ApiController]
    public class AccountControllers : ControllerBase
    {

        private readonly ITokenService _tokenService;

        private readonly SushiDbContext _dbContext;
        public AccountControllers( ITokenService tokenService, SushiDbContext dbContext)
        {

            _tokenService = tokenService;

            _dbContext = dbContext;
        }




    }
}

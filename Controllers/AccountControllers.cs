using System.IdentityModel.Tokens.Jwt;
using Azure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.Account;
using sushi_server.Helper;
using sushi_server.Interfaces;
using sushi_server.Models;

namespace sushi_server.Controllers
{
    [Route("api/account")]
    [ApiController]
    public class AccountControllers : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly ITokenService _tokenService;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly ApplicationDbContext _dbContext;
        public AccountControllers(UserManager<AppUser> userManager, ITokenService tokenService, SignInManager<AppUser> signInManager, ApplicationDbContext dbContext)
        {
            _userManager = userManager;
            _tokenService = tokenService;
            _signInManager = signInManager;
            _dbContext = dbContext;
        }


        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] UserRegisterDto userRegisterDto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                if (await _userManager.FindByEmailAsync(userRegisterDto.Email) != null)
                {
                    return BadRequest("Email has already taken");
                }
                // tạo user mới với email là username
                var appUser = new AppUser
                {
                    UserName = userRegisterDto.Email,
                    Email = userRegisterDto.Email,
                };
                var result = await _userManager.CreateAsync(appUser, userRegisterDto.Password);
                if (!result.Succeeded)
                {
                    return BadRequest(result.Errors);
                }
                // tạo customer mới
                var newCustomer = new Customer
                {
                    CustomerId = Guid.NewGuid(),
                    Name = userRegisterDto.Name,
                    DateOfBirth = userRegisterDto.DateOfBirth,
                    Gender = userRegisterDto.Gender,
                    CitizenId = userRegisterDto.CitizenId,
                    Phone = userRegisterDto.Phone,
                    Email = userRegisterDto.Email
                };
                appUser.CustomerId = newCustomer.CustomerId;
                await _dbContext.Customers.AddAsync(newCustomer);
                await _dbContext.SaveChangesAsync();
                var addRoleResult = await _userManager.AddToRoleAsync(appUser, "User");
                // check coi add role được chưa
                if (!addRoleResult.Succeeded)
                {
                    return BadRequest(addRoleResult.Errors);
                }
                var token = _tokenService.CreateToken(appUser);
                var newUserDto = new NewUserDto
                {
                    UserName = appUser.UserName,
                    Token = token
                };
                return Ok(new Helper.Response<NewUserDto>(newUserDto));

            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] UserLoginDto userLoginDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var user = await _userManager.Users.FirstOrDefaultAsync(u => u.UserName == userLoginDto.UserName.ToLower());

            if (user == null)
            {
                return Unauthorized("Invalid username!");
            }
            var result = await _signInManager.CheckPasswordSignInAsync(user, userLoginDto.Password, false);
            if (!result.Succeeded)
            {
                return Unauthorized("Username not found and/or password incorrect");
            }

            var newUserDto =
                new NewUserDto
                {
                    UserName = userLoginDto.UserName,
                    Token = _tokenService.CreateToken(user)
                };
            return Ok(new Helper.Response<NewUserDto>(newUserDto, "Chúc mừng bạn đã đăng nhập thành công"));

        }
        [HttpGet("test-authorize")]
        [Authorize]
        public IActionResult TestAuthorize()
        {
            return Ok("You are authorized!");
        }
        [HttpGet("me")]
        [Authorize]
        public async Task<IActionResult> GetMeInformation()
        {
            try
            {
                var username = User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")?.Value;
                if (username == null)
                {
                    return BadRequest("Invalid token");
                }
                var user = await _userManager.Users.Include(u => u.Customer).FirstOrDefaultAsync(u => u.UserName == username);
                if (user == null)
                {
                    return BadRequest("User not found");
                }
                var UserMeDto = new UserMeDto
                {
                    UserName = user.UserName,
                    Name = user.Customer?.Name,
                    Phone = user.Customer?.Phone
                };
                return Ok(new Helper.Response<UserMeDto>(UserMeDto));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}

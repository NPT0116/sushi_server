using System.IdentityModel.Tokens.Jwt;
using Azure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
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

[HttpPost("register-employee")]
public async Task<IActionResult> RegisterEmployee([FromBody] EmployeeRegisterDto employeeRegisterDto)
{
    try
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        // Find the employee by EmployeeId
        var employee = await _dbContext.Employees
            .Include(e => e.Branch)
            .FirstOrDefaultAsync(e => e.Id == employeeRegisterDto.EmployeeId);
        if (employee == null)
        {
            return BadRequest("Employee not found");
        }

        // Generate a username by concatenating employee name and branch name, and removing non-alphanumeric characters
        var username = Regex.Replace(employee.Name + employee.Branch.Name, @"\s+", "");
        var email = username + "@example.com";

        // Check if the email is already taken
        if (await _userManager.FindByEmailAsync(email) != null)
        {
            return BadRequest("Email has already taken");
        }

        // Create a new user with the generated username and email
        var appUser = new AppUser
        {
            UserName = username,
            Email = email,
            EmployeeId = employeeRegisterDto.EmployeeId
        };

        var result = await _userManager.CreateAsync(appUser, employeeRegisterDto.Password);
        if (!result.Succeeded)
        {
            return BadRequest(result.Errors);
        }

        // Assign the "Employee" role to the user
        var addRoleResult = await _userManager.AddToRoleAsync(appUser, "Employee");
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

        var user = await _userManager.Users
            .Include(u => u.Customer)
            .Include(u => u.Employee)
            .ThenInclude(e => e.Branch)
            .FirstOrDefaultAsync(u => u.UserName == username);

        if (user == null)
        {
            return BadRequest("User not found");
        }

        var userMeDto = new UserMeDto
        {
            UserName = user.UserName,
            Name = user.Customer?.Name ?? user.Employee?.Name,
            Phone = user.Customer?.Phone,
            CustomerId = user.CustomerId ?? Guid.Empty,
            EmployeeId = user.EmployeeId,
            BranchId = user.Employee?.BranchId,
            DateOfBirth = user.Employee?.Dob
        };

        return Ok(new Helper.Response<UserMeDto>(userMeDto));
    }
    catch (Exception e)
    {
        return BadRequest(e.Message);
    }
}
    }
}

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
using Microsoft.EntityFrameworkCore;
using Dapper;
using System.Data;
using System.Security.Claims;

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

        [HttpPost("Register")]
        public async Task<IActionResult> Register([FromBody] UserRegisterDto registerDto)
        {
            try
            {
                if (registerDto == null)
                {
                return BadRequest("Invalid input data.");
                }

                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                using (var connection = _dbContext.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    var parameters = new DynamicParameters();
                    parameters.Add("@Email", registerDto.Email);
                    parameters.Add("@Password", registerDto.Password);
                    parameters.Add("@DateOfBirth", registerDto.DateOfBirth);
                    parameters.Add("@Phone", registerDto.Phone);
                    parameters.Add("@Name", registerDto.Name);
                    parameters.Add("@Gender", registerDto.Gender);
                    parameters.Add("@CitizenId", registerDto.CitizenId);
                    var result = await connection.ExecuteScalarAsync<string>("createAccount", parameters, commandType: CommandType.StoredProcedure);
                    return Ok(new Helper.Response<string>(result, "Account created successfully."));
                }
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpPost("Login")]
public async Task<IActionResult> Login([FromBody] UserLoginDto loginDto)
{
    try
    {
        // Validate input
        if (loginDto == null)
        {
            return BadRequest("Invalid input data.");
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        // Set up parameters for the stored procedure
        using (var connection = _dbContext.Database.GetDbConnection())
        {
            await connection.OpenAsync();
            var parameters = new DynamicParameters();
            parameters.Add("@username", loginDto.UserName);
            parameters.Add("@password", loginDto.Password);

            // Execute the stored procedure
            var result = await connection.QueryFirstOrDefaultAsync<dynamic>(
                "loginUser", 
                parameters, 
                commandType: CommandType.StoredProcedure
            );

            // Handle the result
            if (result == null || result.Message != "Login successful")
            {
                return Unauthorized(new Helper.Response<string>(result?.Message, "Login failed"));
            }

            // Fetch the Account object based on the username
            var account = await _dbContext.Accounts.FirstOrDefaultAsync(a => a.Username == loginDto.UserName);

            if (account == null)
            {
                return Unauthorized("Invalid login attempt.");
            }

            // Generate a JWT token using the Account object
            var token = _tokenService.CreateToken(account); // Pass the Account object

            return Ok(new Helper.Response<string>(token, "Login successful"));
        }
    }
    catch (Exception e)
    {
        return BadRequest($"Error: {e.Message}");
    }
}
     [HttpGet("authorize")]
    [CustomAuthorize()]
    public IActionResult GetAdminData()
    {
        return Ok(new { message = "you are authorized" });
    }
  [HttpGet("me")]
        [CustomAuthorize]
        public async Task<IActionResult> GetMe()
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var userRole = User.FindFirstValue(ClaimTypes.Role);
            Console.WriteLine(userId);
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized("User not found.");
            }

            using (var connection = _dbContext.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@UserId", Guid.Parse(userId), DbType.Guid);

                if (userRole == "Customer")
                {
                    var customer = await connection.QueryFirstOrDefaultAsync<UserMeDto>(
                        "SELECT u.CustomerId, u.email as Username, Name, Phone " +
                        "FROM Customers u " +
                        "WHERE u.CustomerId = @UserId", parameters);
                    if (customer == null)
                    {
                        return NotFound("User not found.");
                    }

                    return Ok(new
                    {
                        customer.CustomerId,
                        customer.UserName,
                        customer.Name,
                        customer.Phone
                    });
                }
                else if (userRole == "Employee")
                {
                    var employee = await connection.QueryFirstOrDefaultAsync<UserMeDto>(
                        "SELECT c.CustomerId, u.UserName, c.Name, c.Phone, e.EmployeeId, e.BranchId, e.DateOfBirth " +
                        "FROM Users u " +
                        "JOIN Customers c ON u.CustomerId = c.CustomerId " +
                        "JOIN Employees e ON u.EmployeeId = e.EmployeeId " +
                        "WHERE u.Id = @UserId", parameters);

                    if (employee == null)
                    {
                        return NotFound("User not found.");
                    }

                    return Ok(employee);
                }
                else
                {
                    return Unauthorized("Invalid role.");
                }
            }
        }
    }

}

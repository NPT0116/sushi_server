using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Dto.Account;
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
        public AccountControllers(UserManager <AppUser> userManager,  ITokenService tokenService, SignInManager<AppUser> signInManager)
        {
            _userManager = userManager;
            _tokenService = tokenService;
            _signInManager = signInManager;
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
                var appUser = new AppUser
                {
                    UserName = userRegisterDto.UserName,

                };
                var createdUser = await _userManager.CreateAsync(appUser, userRegisterDto.Password);

                if(createdUser.Succeeded)
                {
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                    if(roleResult.Succeeded)
                    {
                        return Ok(new NewUserDto
                        {
                            UserName = appUser.UserName,
                            Token = _tokenService.CreateToken(appUser)
                        });
                    }
                    else
                    {
                        return StatusCode(500, roleResult.Errors);
                    }
                }
                else
                {
                    return StatusCode(500, createdUser.Errors);
                }

            }
            catch(Exception e){
                return StatusCode (500, e);
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
            
            if(user == null)
            {
                return Unauthorized("Invalid username!");
            }
            var result = await _signInManager.CheckPasswordSignInAsync(user, userLoginDto.Password, false );
            if (!result.Succeeded)
            {
                return Unauthorized("Username not found and/or password incorrect");
            }
            return Ok(
                new NewUserDto{
                    UserName = user.UserName,
                    Token = _tokenService.CreateToken(user)
                }
            );
        }
        [HttpGet("test-authorize")]
        [Authorize]
        public IActionResult TestAuthorize()
        {
            return Ok("You are authorized!");
        }

    }
}

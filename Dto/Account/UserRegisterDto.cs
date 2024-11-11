using System;
using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;

namespace sushi_server.Dto.Account
{
    public class UserRegisterDto
    {
        [Required]
        [MinLength(6, ErrorMessage = "Password must be at least 6 characters long.")]
        public string Password { get; set; } = string.Empty;

        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;

        public DateTime? DateOfBirth { get; set; } 
        public Gender Gender { get; set; } 
        [Required]
        [MaxLength(20)]
        public string CitizenId { get; set; } = string.Empty;
        [Required]
        [Phone]
        public string Phone { get; set; } = string.Empty; 
        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;
    }
}

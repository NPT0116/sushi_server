using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Branch
    {
        [Key]
        public Guid BranchId { get; set; }

        public Guid? ManagerId { get; set; }  // Có thể null nếu không có manager

        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;

        [Required]
        [MaxLength(200)]
        public string Address { get; set; } = string.Empty;

        [Phone]
        public string Phone { get; set; } = string.Empty;

        public TimeSpan OpeningTime { get; set; }
        public TimeSpan ClosingTime { get; set; }

        public bool CarParking { get; set; }
        public bool MotorParking { get; set; }
        public bool Ship { get; set; }
        public int TotalTable { get; set; }
    }
}

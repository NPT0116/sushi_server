using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Branch;

public class BranchDetail
{
        [Key]
        public Guid BranchId { get; set; }

        public string Name { get; set; } = string.Empty;


        public string Address { get; set; } = string.Empty;

        [Phone]
        public string Phone { get; set; } = string.Empty;

        public TimeSpan OpeningTime { get; set; }
        public TimeSpan ClosingTime { get; set; }

        public bool CarParking { get; set; }
        public bool MotorParking { get; set; }
        public bool Ship { get; set; }
}

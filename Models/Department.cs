using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Models
{
    public class Department
    {
        [Key]
        public Guid DepartmentId { get; set; }
        [Required]
        public string DepartmentName { get; set; } = string.Empty;
        public int BaseSalary { get; set; }
    }
}
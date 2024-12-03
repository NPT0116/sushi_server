using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Employee
    {
        [Key]
        public Guid Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public DateTime Dob { get; set; }
        public string Gender { get; set; } = string.Empty;
        public int Salary { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? ResignedDate { get; set; }
        public Guid DepartmentId { get; set; }
        public Department? Department { get; set; }
        public Guid BranchId { get; set; }
        public Branch? Branch { get; set; }
    public ICollection<WorkHistory> WorkHistories { get; set; }

    }
}

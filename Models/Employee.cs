using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Employee
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime Dob { get; set; }
        public string Gender { get; set; }
        public int Salary { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? ResignedDate { get; set; } 

    }
}

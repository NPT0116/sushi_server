using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Models
{
    public class WorkHistory
    {
        public Guid Id { get; set; }
        public Guid EmployeeId { get; set; }
        public Employee Employee { get; set; }
        public Guid BranchId { get; set; }
        public Branch Branch { get; set; }
        public DateOnly StartDate { get; set; }
        public DateOnly ResignDate { get; set; }
        public Guid DepartmentId { get; set; }
        public Department Department { get; set; }

    }
}
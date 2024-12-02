using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.Employee
{
    public class EmployeeRegisterDto
    {
           public Guid EmployeeId { get; set; }
    public string Password { get; set; }
    }
}
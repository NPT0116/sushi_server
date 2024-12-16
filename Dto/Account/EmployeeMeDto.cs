using System;

namespace sushi_server.Dto.Account;

public class EmployeeMeDto
{
    public Guid? EmployeeId { get; set; }
<<<<<<< HEAD
    public DateTime? DateOfBirth { get; set; }
    public String Name { get; set; }
    public Guid BranchId { get; set; }
    public String BranchName { get; set; } = string.Empty;  
    public String DepartmentName { get; set; } = string.Empty;
    public Guid DepartmentId { get; set; }

=======
    public Guid? BranchId { get; set; }
    public DateTime? DateOfBirth { get; set; }
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
}

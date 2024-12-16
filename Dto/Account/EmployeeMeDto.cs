using System;

namespace sushi_server.Dto.Account;

public class EmployeeMeDto
{
    public Guid? EmployeeId { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public String Name { get; set; }
    public Guid BranchId { get; set; }
    public String BranchName { get; set; } = string.Empty;  
    public String DepartmentName { get; set; } = string.Empty;
    public Guid DepartmentId { get; set; }

}

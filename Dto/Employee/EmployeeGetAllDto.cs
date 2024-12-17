using System;

namespace sushi_server.Dto.Employee;

public class EmployeeGetAllDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateTime Dob { get; set; }
    public string Gender { get; set; } = string.Empty;
    public int Salary { get; set; }
    public Guid BranchId { get; set; }
    public String BranchName { get; set; } = string.Empty;  
    public String DepartmentName { get; set; } = string.Empty;
    public Guid DepartmentId { get; set; }
}

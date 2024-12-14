using System;

namespace sushi_server.Dto.Account;

public class EmployeeMeDto
{
    public Guid? EmployeeId { get; set; }
    public Guid? BranchId { get; set; }
    public DateTime? DateOfBirth { get; set; }
}

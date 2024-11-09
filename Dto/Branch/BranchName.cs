using System;

namespace sushi_server.Dto.Branch;

public class BranchName
{
    public Guid BranchId { get; set; }
    public string Name { get; set; } = string.Empty;
}

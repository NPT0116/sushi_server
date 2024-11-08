using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Section;

public class SectionGetAll
{
    public Guid SectionId { get; set; }
    [Required]
    public string SectionName { get; set; } = string.Empty;
}

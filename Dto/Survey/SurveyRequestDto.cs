using System;

namespace sushi_server.Dto.Survey;

public class SurveyRequestDto
{
    public Guid InvoiceId { get; set; }
    public int Point { get; set; }
    public string Comment { get; set; } = string.Empty;
}

using Microsoft.AspNetCore.Mvc;
using sushi_server.Data;
using sushi_server.Models;
using sushi_server.Dto.Survey;
using Dapper;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace sushi_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SurveyController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public SurveyController(ApplicationDbContext context)
        {
            _context = context;
        }

  
        [HttpPost("create")]
        public async Task<IActionResult> CreateSurvey([FromBody] SurveyRequestDto request)
        {
            if (request == null || request.InvoiceId == Guid.Empty)
            {
                return BadRequest("Invalid survey data.");
            }


            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@InvoiceId", request.InvoiceId, DbType.Guid);
                parameters.Add("@Point", request.Point, DbType.Int32);
                parameters.Add("@Comment", request.Comment, DbType.String);

                await connection.ExecuteAsync("submitSurvey", parameters, commandType: CommandType.StoredProcedure);
            }



            return Ok(new { Message = "Survey created successfully"});
        }
    }
}
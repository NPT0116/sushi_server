using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Models;
using System.Threading.Tasks;
using System;
using System.Data;
using Dapper;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CardController : ControllerBase
    {
        private readonly SushiDbContext _context;

        public CardController(SushiDbContext context)
        {
            _context = context;
        }

        // API lấy thông tin thẻ của khách hàng bao gồm thông tin ranking chi tiết
        [HttpGet("{customerId}")]
        public async Task<IActionResult> GetCardByCustomerId(Guid customerId)
        {
            // Tìm thẻ khách hàng từ bảng Cards kèm theo thông tin Ranking từ bảng Rankings
            var card = await _context.Cards
                .Include(c => c.Ranking) // Bao gồm thông tin về Ranking
                .FirstOrDefaultAsync(c => c.CustomerId == customerId);

            // Kiểm tra xem khách hàng có thẻ không
            if (card == null)
            {
                return NotFound($"Card for customer {customerId} not found.");
            }

            // Trả về thông tin thẻ và chi tiết về ranking
            return Ok(card);
        }
           [HttpPost("createCardForCustomer")]
        public async Task<IActionResult> CreateCardForCustomer([FromQuery] Guid customerId, [FromQuery] Guid employeeId)
        {
            if (customerId == Guid.Empty || employeeId == Guid.Empty)
            {
                return BadRequest("CustomerId and EmployeeId are required.");
            }

            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();

                    var parameters = new DynamicParameters();
                    parameters.Add("@CustomerId", customerId, DbType.Guid);
                    parameters.Add("@EmployeeId", employeeId, DbType.Guid);

                    var cardId = await connection.QueryFirstOrDefaultAsync<Guid>(
                        "createCardForCustomer",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    return Ok(new { CardId = cardId });
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }
    }

 
}

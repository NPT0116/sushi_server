using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Models;
using System.Threading.Tasks;
using System;

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
    }
}

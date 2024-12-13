using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Dto.Order;
using sushi_server.Models;
using sushi_server.Models.Enum;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/order")]
    public class OrderController : ControllerBase
    {
        private readonly SushiDbContext _context;
        public OrderController(SushiDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetOrders()
        {
            var orders = await _context.Orders.ToListAsync();
            return Ok(orders);
        }

    }
}

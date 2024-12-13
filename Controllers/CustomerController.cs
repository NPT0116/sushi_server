using Microsoft.AspNetCore.Mvc;
 
using sushi_server.Models;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/customer")]
    public class CustomerController : ControllerBase
    {
        private readonly SushiDbContext _context;

        public CustomerController(SushiDbContext context)
        {
            _context = context;
        }

        // API lấy thông tin khách hàng theo customerId
        [HttpGet("{customerId}")]
        public async Task<IActionResult> GetCustomer(Guid customerId)
        {
            // Tìm khách hàng trong cơ sở dữ liệu
            var customer = await _context.Customers
                .FirstOrDefaultAsync(c => c.CustomerId == customerId);

            // Nếu không tìm thấy khách hàng
            if (customer == null)
            {
                return NotFound($"Customer with ID {customerId} not found.");
            }

            // Trả về thông tin khách hàng
            return Ok(customer);
        }
    }
}

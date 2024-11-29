using Microsoft.AspNetCore.Mvc;
using sushi_server.Models;
using sushi_server.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Dapper;
using System.Data;

namespace sushi_server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class InvoiceController : ControllerBase {
    private readonly ApplicationDbContext _context;

    public InvoiceController(ApplicationDbContext context) {
        _context = context;
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> getInvoice(string id) {
        Invoice newInvoice = await _context.Invoices
                .Include(i => i.Order)
                .ThenInclude(o => o.OrderDetails)
                .ThenInclude(od => od.Dish)
                .FirstOrDefaultAsync(i => i.Id == Guid.Parse(id));
        if (newInvoice == null) {
            return NotFound();
        }
        return Ok(newInvoice.toInvoiceResponseDTO());
    }
    [HttpPatch("{id}/paid")]
    public async Task<IActionResult> setPaid(string id) {
        Invoice invoice = await _context.Invoices.FindAsync(Guid.Parse(id));
        invoice.Paid = true;
        _context.SaveChanges();
        return Ok();
    }


    [HttpPost("createInvoice")]
        public async Task<IActionResult> CreateInvoice([FromQuery] Guid orderId, [FromQuery] string paymentMethod)
        {
            if (orderId == Guid.Empty || string.IsNullOrEmpty(paymentMethod))
            {
                return BadRequest("OrderId and PaymentMethod are required.");
            }

            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();

                    var parameters = new DynamicParameters();
                    parameters.Add("@OrderId", orderId, DbType.Guid);
                    parameters.Add("@paymentMethod", paymentMethod, DbType.String);

                    // Gọi stored procedure để tạo hóa đơn và cập nhật thẻ khách hàng
                    var invoice = await connection.QueryFirstOrDefaultAsync<Invoice>(
                        "CreateInvoiceAndUpdateCustomerCard", // Tên stored procedure
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    // Nếu không có kết quả thì có lỗi xảy ra
                    if (invoice == null)
                    {
                        return StatusCode(500, "Error occurred while creating the invoice.");
                    }

                    // Trả về thông tin hóa đơn mới tạo
                    return Ok(invoice);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }
}   
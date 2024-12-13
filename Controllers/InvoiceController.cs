using Microsoft.AspNetCore.Mvc;
using sushi_server.Models;
 
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Dapper;
using System.Data;
using sushi_server.Helper;

namespace sushi_server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class InvoiceController : ControllerBase
{
    private readonly SushiDbContext _context;

    public InvoiceController(SushiDbContext context)
    {
        _context = context;
    }
    // [HttpGet("{id}")]
    // public async Task<IActionResult> getInvoice(string id) {
    //     Invoice newInvoice = await _context.Invoices
    //             .Include(i => i.Order)
    //             .ThenInclude(o => o.OrderDetails)
    //             .ThenInclude(od => od.Dish)
    //             .FirstOrDefaultAsync(i => i.Id == Guid.Parse(id));
    //     if (newInvoice == null) {
    //         return NotFound();
    //     }
    //     return Ok(newInvoice.toInvoiceResponseDTO());
    // }
    // [HttpPatch("{id}/paid")]
    // public async Task<IActionResult> setPaid(string id) {
    //     Invoice invoice = await _context.Invoices.FindAsync(Guid.Parse(id));
    //     invoice.Paid = true;
    //     _context.SaveChanges();
    //     return Ok();
    // }


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
                return Ok(new Response<Invoice>(invoice, "Invoice created successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }

    [HttpPatch("updatePaidInvoice/{invoiceId}")]
    public async Task<IActionResult> UpdatePaidInvoice(Guid invoiceId)
    {
        if (invoiceId == Guid.Empty)
        {
            return BadRequest("InvoiceId is required.");
        }

        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@InvoiceId", invoiceId, System.Data.DbType.Guid);

                // Gọi stored procedure để cập nhật trạng thái Paid của hóa đơn
                var result = await connection.ExecuteAsync(
                    "UpdatePaidInvoice", // Tên stored procedure
                    parameters,
                    commandType: System.Data.CommandType.StoredProcedure
                );

                // Kiểm tra kết quả và trả về thông báo thành công
                if (result == 0)
                {
                    return NotFound("Invoice not found.");
                }

                return Ok(new { Message = "Invoice updated successfully." });
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }
}
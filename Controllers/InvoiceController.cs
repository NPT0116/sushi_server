using Microsoft.AspNetCore.Mvc;
using sushi_server.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Dapper;
using System.Data;
using sushi_server.Helper;
using Dto.Invoice;
using sushi_server.Dto.OrderDetail;
using sushi_server.Dto.Invoice;
using sushi_server.Data;

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

    [HttpPost("createInvoice")]
     public async Task<IActionResult> CreateInvoice([FromQuery] Guid orderId, [FromQuery] string paymentMethod)
        {
            if (orderId == Guid.Empty || string.IsNullOrEmpty(paymentMethod))
            {
                return BadRequest("OrderId and PaymentMethod are required.");
            }

            try
            {
                var orderIdParam = new SqlParameter("@OrderId", orderId);
                var paymentMethodParam = new SqlParameter("@paymentMethod", paymentMethod);

                // Execute the stored procedure
                await _context.Database.ExecuteSqlRawAsync("EXEC CreateInvoiceAndUpdateCustomerCard @OrderId, @paymentMethod", orderIdParam, paymentMethodParam);

                // Retrieve the created invoice
                var invoice = await _context.Invoices
                    .FromSqlRaw("SELECT * FROM Invoices WHERE OrderId = @OrderId", orderIdParam)
                      .FirstOrDefaultAsync();


                if (invoice == null)
                {
                    return StatusCode(500, "Error occurred while creating the invoice.");
                }

                return Ok(new Response<Invoice>(invoice, "Invoice created successfully."));
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

    [HttpGet("query")]
    public async Task<IActionResult> QueryInvoices(Guid? branchId, DateTime startDate, DateTime endDate, string? phone)
    {
        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@BranchId", branchId, DbType.Guid);
                parameters.Add("@StartDate", startDate, DbType.DateTime);
                parameters.Add("@EndDate", endDate, DbType.DateTime);
                parameters.Add("@Phone", phone, DbType.String);

                var invoices = await connection.QueryAsync<InvoiceResponseDTO>(
                    "QueryInvoicesByBranchAndDateWithPartition2", // Stored procedure name
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                return Ok(new Response<IEnumerable<InvoiceResponseDTO>>(invoices, "Invoices retrieved successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }

    [HttpGet("latestInvoicesByCustomer")]
    public async Task<IActionResult> GetLatestInvoicesByCustomer([FromQuery] Guid customerId)
    {
        if (customerId == Guid.Empty)
        {
            return BadRequest("CustomerId is required.");
        }

        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@CustomerId", customerId, DbType.Guid);

                var invoices = await connection.QueryAsync<InvoicesDto>(
                    "GetLatestInvoicesByCustomer", // Stored procedure name
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                return Ok(new Response<IEnumerable<InvoicesDto>>(invoices, "Latest invoices retrieved successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }

    [HttpGet("latestInvoicesByOrder")]
    public async Task<IActionResult> GetLatestInvoicesByOrder([FromQuery] Guid orderId)
    {
        if (orderId == Guid.Empty)
        {
            return BadRequest("OrderId is required.");
        }

        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@OrderId", orderId, DbType.Guid);

                var invoices = await connection.QueryAsync<Invoice>(
                    "GetLatestInvoicesByOrder", // Stored procedure name
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                return Ok(new Response<IEnumerable<Invoice>>(invoices, "Latest invoices retrieved successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }
      [HttpGet("{invoiceId}/dishes")]
        public async Task<IActionResult> GetDishesFromInvoiceId(Guid invoiceId)
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
                    parameters.Add("@InvoiceId", invoiceId, DbType.Guid);

                    var dishes = await connection.QueryAsync<OrderDetailDishDto>(
                        "getDishesFromInvoiceId", // Stored procedure name
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    return Ok(new Response<IEnumerable<OrderDetailDishDto>>(dishes, "Dishes retrieved successfully."));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }
}
using Microsoft.AspNetCore.Mvc;
using sushi_server.Models;
using sushi_server.Data;
using Microsoft.EntityFrameworkCore;

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
}   
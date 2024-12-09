using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.Order;
using sushi_server.Models;
using sushi_server.Models.Enum;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/order")]
    public class OrderController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public OrderController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetOrders()
        {
            var orders = await _context.Orders.ToListAsync();
            return Ok(orders);
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrderById(string id)
        {
            Order order = GetOrderWithDetails(Guid.Parse(id));
            if (order == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(order.ToResponseDTO());
            }
        }
        private Order? GetOrderWithDetails(Guid orderId)
        {
            return _context.Orders
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Dish)
                .FirstOrDefault(o => o.Id == orderId);
        }


        [HttpPost]
        public async Task<IActionResult> submitOrder([FromBody] OrderRequestDTO order)
        {
            List<OrderDetail> orderDetails = new List<OrderDetail>();
            Guid orderId = Guid.NewGuid();
            orderDetails = order.OrderDetails.Select(od => new OrderDetail
            {
                Id = Guid.NewGuid(),
                Status = OrderStatus.Placed,
                Quantity = od.Quantity,
                Price = _context.Dishes.Find(od.DishId)?.CurrentPrice ?? 0,
                DishId = od.DishId,
            }).ToList();

            _context.Orders.Add(new Order
            {
                Id = orderId,
                LastModified = DateTime.Now,
                Status = OrderStatus.Placed,
                Reservation = _context.Reservation.Find(order.ReservationId),
                OrderDetails = orderDetails
            });
            await _context.SaveChangesAsync();
            return Ok(new { orderId = orderId });
        }

        [HttpPost("{id}/payment")]
        public async Task<IActionResult> payOrder(string id, [FromQuery] string paymentMethod)
        {
            Guid invoiceId = Guid.NewGuid();
            Invoice invoice = new Invoice
            {
                Id = invoiceId,
                PaymentMethod = paymentMethod,
                OrderId = Guid.Parse(id),
                DatedOn = DateTime.Now,
                Paid = false,
            };
            _context.Invoices.Add(invoice);
            _context.SaveChanges();
            Invoice newInvoice = await _context.Invoices
                .Include(i => i.Order)
                .ThenInclude(o => o.OrderDetails)
                .ThenInclude(od => od.Dish)
                .FirstOrDefaultAsync(i => i.Id == invoiceId);
            return Ok(newInvoice.toInvoiceResponseDTO());
        }
    }
}

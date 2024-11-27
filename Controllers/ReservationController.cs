using Microsoft.AspNetCore.Mvc;
using sushi_server.Data;
using sushi_server.Dto.Reservation;
using sushi_server.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace YourNamespace.Controllers
{
    [ApiController]
    [Route("api/reservation")]
    public class ReservationController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public ReservationController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpPost]
public async Task<IActionResult> SubmitReservation([FromBody] ReservationSubmitRequestDTO request)
{
    if (!ModelState.IsValid)
    {
        return BadRequest(ModelState);
    }

    // Parse string IDs to Guid
    if (!Guid.TryParse(request.CustomerId, out Guid customerId))
    {
        return BadRequest("Invalid CustomerId format.");
    }

    if (!Guid.TryParse(request.BranchId, out Guid branchId))
    {
        return BadRequest("Invalid BranchId format.");
    }

    if (!Guid.TryParse(request.TableId, out Guid tableId))
    {
        return BadRequest("Invalid TableId format.");
    }

    var reservationIdParam = new SqlParameter("@reservation_id", System.Data.SqlDbType.UniqueIdentifier)
    {
        Direction = System.Data.ParameterDirection.Output
    };

    try
    {
        // Call the stored procedure
        var result = await _context.Database.ExecuteSqlRawAsync(
            "EXEC submit_reservation @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @reservation_id OUT",
            request.DatedOn,
            request.Note,
            request.Status,
            request.TotalPeople,
            request.OrderedBy,
            customerId,
            branchId,
            tableId,
            reservationIdParam
        );

        Console.WriteLine($"SQL Result: {result}");

        // Retrieve the reservation ID from the output parameter
        Guid newReservationId = (Guid)reservationIdParam.Value;

        // Retrieve the reservation details
        var reservation = await GetReservationByIdAsync(newReservationId);

        // Return the reservation details as part of the response
        return Ok(new { Reservation = reservation });
    }
    catch (SqlException ex)
    {
        // Log the exception details
        Console.WriteLine($"SQL Error: {ex.Message}");
        return StatusCode(500, "Internal server error");
    }
}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetReservationById(Guid id)
        {
            return Ok(await GetReservationByIdAsync(id));
        }

        private async Task<Reservation> GetReservationByIdAsync(Guid id) {
            var reservation = await _context.Reservation.FindAsync(id);
            if (reservation == null) {
                return null;
            }
            return reservation;
        }
    }
}

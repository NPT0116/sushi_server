using Microsoft.AspNetCore.Mvc;
using sushi_server.Data;
using sushi_server.Dto.Reservation;
using sushi_server.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Data;
using sushi_server.Helper;
using Sushi_server.Dto.Reservation;

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
        public async Task<IActionResult> SubmitReservation([FromBody] ReservationSubmitRequest request)
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

        // Parse the DatedOn string into DateTime
        if (!DateTime.TryParseExact(request.DatedOn, "dd/MM/yyyy", 
            CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime datedOn))
        {
            return BadRequest("Invalid DatedOn format. Please use dd/MM/yyyy.");
        }

        var reservationIdParam = new SqlParameter("@reservation_id", System.Data.SqlDbType.UniqueIdentifier)
        {
            Direction = System.Data.ParameterDirection.Output
        };

        try
        {
            // Call the stored procedure with the parsed DatedOn
            var result = await _context.Database.ExecuteSqlRawAsync(
                "EXEC submit_reservation @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @reservation_id OUT",
                datedOn, // Pass the DateTime here
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

            // Create the response DTO
            var reservationResponse = new ReservationResponseDTO
            {
                Id = newReservationId,
                DatedOn = datedOn,
                Note = request.Note,
                Status = request.Status,
                TotalPeople = request.TotalPeople,
                OrderedBy = request.OrderedBy,
                CustomerId = customerId,
                BranchId = branchId,
                TableId = tableId
            };

            // Return the reservation details as part of the response
            return Ok(new { Reservation = reservationResponse });
        }
        catch (SqlException ex)
        {
            // Log the exception details
            Console.WriteLine($"SQL Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }
        [HttpGet("getReservations")]
public async Task<IActionResult> GetReservations([FromQuery] GetReservationsQuery query)
{
    if (!query.BranchId.HasValue || !query.DatedOn.HasValue)
    {
        return BadRequest("BranchId and DatedOn are required.");
    }

    var branchIdParam = new SqlParameter("@BranchId", SqlDbType.UniqueIdentifier) { Value = query.BranchId.Value };
    var datedOnParam = new SqlParameter("@DatedOn", SqlDbType.Date) { Value = query.DatedOn.Value.Date };

    try
    {
        // Execute the stored procedure to get the reservations
        var reservations = await _context.Reservation
            .FromSqlRaw("EXEC dbo.GetReservationsByBranchAndDate @BranchId, @DatedOn", branchIdParam, datedOnParam)
            .ToListAsync();

        // Return the list of reservations
        return Ok(new Response<List<Reservation>> (reservations, "retrieved reservations successfully"));
    }
    catch (Exception ex)
    {
        // Handle errors
        Console.WriteLine($"Error: {ex.Message}");
        return StatusCode(500, "Internal server error");
    }
}


        private async Task<Reservation> GetReservationByIdAsync(Guid id) {
            var reservation = await _context.Reservation.FindAsync(id);
            if (reservation == null) {
                return null;
            }
            return reservation;
        }
    }

    internal class ReservationResponseDTO
    {
        public Guid Id { get; set; }
        public DateTime DatedOn { get; set; }
        public object Note { get; set; }
        public object Status { get; set; }
        public object TotalPeople { get; set; }
        public object OrderedBy { get; set; }
        public Guid CustomerId { get; set; }
        public Guid BranchId { get; set; }
        public Guid TableId { get; set; }
    }
}

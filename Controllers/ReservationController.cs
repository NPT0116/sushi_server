using Microsoft.AspNetCore.Mvc;
 
using sushi_server.Dto.Reservation;
using sushi_server.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Data;
using sushi_server.Helper;
using sushi_server.Models;
using sushi_server.Dto.OrderDetail;
using Dapper;

namespace YourNamespace.Controllers
{
    [ApiController]
    [Route("api/reservation")]
    public class ReservationController : ControllerBase
    {
        private readonly SushiDbContext _context;
        public ReservationController(SushiDbContext context)
        {
            _context = context;
        }


        [HttpGet("getDetailReservationCards")]
        public async Task<IActionResult> getDetailReservationCards([FromQuery] GetReservationsQuery query)
        {
            if (!query.BranchId.HasValue || !query.DatedOn.HasValue)
            {
                return BadRequest("BranchId and DatedOn are required.");
            }
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    var reservations = await connection.QueryAsync<ReservationCards>(
                        "getDetailReservationCards",
                        new { branchId = query.BranchId.Value, dateOn = query.DatedOn.Value },
                        commandType: CommandType.StoredProcedure
                    );
                    foreach (var reservation in reservations)
                    {
                        var orderDetails = await connection.QueryAsync<OrderDetailDto>(
                            "getOrderDetailsByReservationId",
                            new { reservationId = reservation.ReservationId },
                            commandType: CommandType.StoredProcedure
                        );

                        reservation.OrderDetails = orderDetails.ToList();
                    }
                    return Ok(new Response<List<ReservationCards>>(reservations.ToList(), "Retrieved reservation cards successfully"));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }


        [HttpPost("submit")]
        public async Task<IActionResult> SubmitReservationWithOrder([FromBody] ReservationOrderRequest request)
        {
            // Khai báo các biến
            Guid reservationId = Guid.Empty;
            Guid orderId = Guid.Empty;

            try
            {
                // Kết nối đến cơ sở dữ liệu
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();

                    // Thực thi stored procedure customerSubmitReservation để tạo Reservation
                    var reservationParameters = new DynamicParameters();
                    reservationParameters.Add("@note", request.Note);
                    reservationParameters.Add("@datedOn", request.DatedOn);
                    reservationParameters.Add("@customerId", request.CustomerId);
                    reservationParameters.Add("@branchId", request.BranchId);
                    reservationParameters.Add("@totalPeople", request.TotalPeople);
                    reservationParameters.Add("@id", dbType: DbType.Guid, direction: ParameterDirection.Output); // OUT parameter

                    // Gọi stored procedure để tạo Reservation
                    await connection.ExecuteAsync("customerSubmitReservation", reservationParameters, commandType: CommandType.StoredProcedure);

                    // Lấy ReservationId sau khi tạo xong
                    reservationId = reservationParameters.Get<Guid>("@id");
                    Console.WriteLine("ReservationId: " + reservationId);

                    // Kiểm tra nếu ReservationId không hợp lệ
                    if (reservationId == Guid.Empty)
                    {
                        return BadRequest("Failed to create reservation.");
                    }

                    // Thực thi stored procedure createOrderFromReservation để tạo Order từ Reservation
                    var orderParameters = new DynamicParameters();
                    orderParameters.Add("@reservationId", reservationId);
                    orderParameters.Add("@orderId", dbType: DbType.Guid, direction: ParameterDirection.Output); // OUT parameter

                    // Gọi stored procedure để tạo Order từ Reservation
                    await connection.ExecuteAsync("createOrderFromReservation", orderParameters, commandType: CommandType.StoredProcedure);

                    // Lấy OrderId từ OUT parameter
                    orderId = orderParameters.Get<Guid>("@orderId");

                    // Kiểm tra nếu OrderId không hợp lệ
                    if (orderId == Guid.Empty)
                    {
                        return BadRequest("Failed to create order.");
                    }

                    // Thêm OrderDetails cho món ăn trong Order
                    foreach (var orderDetail in request.OrderDetails)
                    {
                        var orderDetailParams = new DynamicParameters();
                        orderDetailParams.Add("@orderId", orderId);
                        orderDetailParams.Add("@dishId", orderDetail.DishId);
                        orderDetailParams.Add("@branchId", request.BranchId);
                        orderDetailParams.Add("@quantity", orderDetail.Quantity);

                        // Gọi stored procedure để tạo OrderDetail cho mỗi món ăn
                        await connection.ExecuteAsync("createOrderDetailFromOrder", orderDetailParams, commandType: CommandType.StoredProcedure);
                    }

                    // Trả về thông tin đơn đặt chỗ, đơn hàng và chi tiết đơn hàng
                    var response = new
                    {
                        ReservationId = reservationId,
                        OrderId = orderId,
                        OrderDetails = request.OrderDetails
                    };

                    return Ok(new Response<object>(response, "Reservation and order created successfully."));
                }
            }
            catch (Exception ex)
            {
                // Trả về thông báo lỗi nếu có exception
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }


        [HttpPost("updateReservationStatus")]
        public async Task<IActionResult> UpdateReservationStatus([FromBody] UpdateReservationRequest request)
        {
            if (request == null)
            {
                return BadRequest("Invalid data.");
            }
            Console.WriteLine("tableId: " + request.TableId);
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();

                    var parameters = new DynamicParameters();
                    parameters.Add("@ReservationId", request.ReservationId, DbType.Guid);
                    parameters.Add("@EmployeeId", request.EmployeeId, DbType.Guid);
                    parameters.Add("@TableId", request.TableId, DbType.Guid);

                    var result = await connection.ExecuteScalarAsync<string>("UpdateReservationStatusAndDetails", parameters, commandType: CommandType.StoredProcedure);

                    return Ok(new Response<string>(result, "Updated reservation status successfully."));
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }



    }
}

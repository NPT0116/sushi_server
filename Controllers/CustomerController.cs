using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using sushi_server.Models;
using sushi_server.Helper;

namespace sushi_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly SushiDbContext _context;
        private readonly IMapper _mapper;

        public CustomerController(SushiDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

            [HttpGet("all")]
        public async Task<IActionResult> GetCustomersWithSingleActiveCard([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10, [FromQuery] string phoneNumber = null)
        {
           using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                var parameters = new DynamicParameters();
                parameters.Add("@PageNumber", pageNumber);
                parameters.Add("@PageSize", pageSize);
                parameters.Add("@PhoneNumber", phoneNumber);

                var customers = await connection.QueryAsync<CustomerWithCardDto>(
                    "getCustomersWithSingleActiveCard", 
                    parameters,
                    commandType: System.Data.CommandType.StoredProcedure);

                return Ok(new PagedResponse<List<CustomerWithCardDto>>(customers.ToList(), pageNumber, pageSize, "Retrieved data", null, true));
            }
        }
    }

    public class CustomerWithCardDto
    {
        public Guid CustomerId { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public string CitizenId { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Email { get; set; }
        public string Gender { get; set; }
        public Guid CardId { get; set; }
        public float AccumulatedPoints { get; set; }
        public DateTime? AccumulatedDate { get; set; }
        public bool Valid { get; set; }
        public string RankName { get; set; }
    }
}
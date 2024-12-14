using System;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Dto.TableDetail;
using sushi_server.Helper;
using sushi_server.Models;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/table-detail")]
    public class TableDetailController : ControllerBase
    {
        private readonly SushiDbContext _dbContext;
        private readonly IMapper _mapper;

        public TableDetailController(SushiDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        [HttpGet("empty-tables")]
        public async Task<IActionResult> GetEmptyTables([FromQuery] Guid branchId)
        {
            try
            {
                Console.WriteLine($"Received request to get empty tables for branchId: {branchId}");

                var emptyTables = await _dbContext.TableDetails
                    .Where(t => t.Status == false && t.BranchId == branchId)
                    .ToListAsync();

                Console.WriteLine("Empty tables retrieved from database:");
                foreach (var table in emptyTables)
                {
                    Console.WriteLine($"TableId: {table.TableId}, TableNumber: {table.TableNumber}, BranchId: {table.BranchId}, Status: {table.Status}");
                }

                var emptyTableDtos = _mapper.Map<List<TableDetailDto>>(emptyTables);

                Console.WriteLine("Mapped TableDetailDto objects:");
                foreach (var dto in emptyTableDtos)
                {
                    Console.WriteLine($"TableId: {dto.TableId}, TableNumber: {dto.TableNumber}");
                }

                return Ok(new Response<List<TableDetailDto>>(emptyTableDtos, "Retrieved empty tables successfully"));
            }
            catch (Exception e)
            {
                Console.WriteLine($"An error occurred: {e.Message}");
                return StatusCode(500, new { message = e.Message });
            }
        }
    }
}
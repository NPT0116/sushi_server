using System;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto;
using sushi_server.Dto.TableDetail;
using sushi_server.Models;

namespace sushi_server.Controllers
{
    [ApiController]
    [Route("api/table-detail")]
    public class TableDetailController : ControllerBase
    {
        private readonly ApplicationDbContext _dbContext;
        private readonly IMapper _mapper;

        public TableDetailController(ApplicationDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        [HttpGet("empty-tables")]
        public async Task<IActionResult> GetEmptyTables([FromQuery] Guid branchId)
        {
            try
            {
                var emptyTables = await _dbContext.TableDetail
                    .Where(t => t.Status == 0 && t.BranchId == branchId)
                    .ToListAsync();

                var emptyTableDtos = _mapper.Map<List<TableDetailDto>>(emptyTables);

                return Ok(emptyTableDtos);
            }
            catch (Exception e)
            {
                return StatusCode(500, new { message = e.Message });
            }
        }
    }
}
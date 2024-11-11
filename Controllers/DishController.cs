using Dapper;
using AutoMapper;

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.Dish;
using sushi_server.Helper;
using sushi_server.Models;
using sushi_server.Filters;
using System.Data;

namespace sushi_server.Controllers
{
    [Route("api/dish")]
    [ApiController]
    public class DishController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public DishController(ApplicationDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet("pagination")]
        public async Task<IActionResult> GetAllPagination([FromQuery] int PageNumber, int PageSize)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@PageNumber", PageNumber, DbType.Int32);
                    parameters.Add("@PageSize", PageSize, DbType.Int32);
                    var dishes = await connection.QueryAsync<Dish> (
                        "GetAllDishes",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );
                    var totalRecords = await connection.ExecuteScalarAsync<int>(
                         "SELECT COUNT(1) FROM Dishes ",
                        parameters
                    );
                    var dishDtoList = _mapper.Map<List<GetAllDishDto>>(dishes);
                    var paginatedResponse = new PagedResponse<List<GetAllDishDto>>
                    (
                        dishDtoList, PageNumber, PageSize, "Retrieved data with PageNumber:" + PageNumber, null, true
                    )
                    {
                        TotalRecords = totalRecords,
                        TotalPages = (int)Math.Ceiling(totalRecords / (double)PageSize),

                    };
                    return Ok(paginatedResponse);
                }
                
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpGet()]
        public async Task<IActionResult> GetAll([FromQuery] DishFilter dishFilter)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@DishName", dishFilter.DishName, DbType.String);
                    parameters.Add("@MinPrice", dishFilter.MinPrice, DbType.Int32);
                    parameters.Add("@MaxPrice", dishFilter.MaxPrice, DbType.Int32);

                  var dishes = await connection.QueryAsync<Dish> (
                        "GetAllDishes",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    var dishDtoList = _mapper.Map<List<GetAllDishDto>>(dishes);
                    return Ok(new Response<List<GetAllDishDto>>(dishDtoList, "Data retrieved successfully"));
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpGet("by-section:{SectionId}")]
        public async Task<IActionResult> GetDishesBySectionId([FromRoute] Guid SectionId)
        {
            try
            {
                using(var connection = _context.Database.GetDbConnection())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@SectionId", SectionId, DbType.Guid);
                    var dishesBySectionId = await connection.QueryAsync<GetDishesBySectionIdDto>(
                        "GetDishesBySectionId",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );
                    return Ok(new Helper.Response<List<GetDishesBySectionIdDto>>(dishesBySectionId.ToList(), "Get dishes for sectionId: " + SectionId));
                }
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpGet("available/branch:{BranchId}")]
        public async Task<IActionResult> GetDishesAvailableWithBranchId([FromRoute] Guid BranchId)
        {
            try{
                Console.WriteLine(BranchId);
                var availableDishes = await _context.BranchDishes.Where(bd => bd.BranchId == BranchId && bd.Status == true).Select(bd => bd.Dish).ToListAsync();
                if (availableDishes.Count == 0)
                {
                    return BadRequest("No available dishes to this branch");
                }
                Console.WriteLine(availableDishes.Count);

                var availableDishesDto = _mapper.Map<List<AvailableDishesInBranchDto>>(availableDishes);
                return Ok (new Helper.Response<List<AvailableDishesInBranchDto>> (availableDishesDto));
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }

    }
}

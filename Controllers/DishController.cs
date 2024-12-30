using Dapper;
using AutoMapper;

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Dto.Dish;
using sushi_server.Helper;
using sushi_server.Models;
using sushi_server.Filters;
using System.Data;
using sushi_server.Data;

namespace sushi_server.Controllers
{
    [Route("api/dish")]
    [ApiController]
    public class DishController : ControllerBase
    {
        private readonly SushiDbContext _context;
        private readonly IMapper _mapper;
        public DishController(SushiDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
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
                    parameters.Add("@BranchId", dishFilter.BranchId, DbType.Guid);
                    parameters.Add("@SectionId", dishFilter.SectionId, DbType.Guid);
                    parameters.Add("@MinPrice", dishFilter.MinPrice, DbType.Int32);
                    parameters.Add("@MaxPrice", dishFilter.MaxPrice, DbType.Int32);
                    parameters.Add("@PageNumber", dishFilter.PageNumber, DbType.Int32);
                    parameters.Add("@PageSize", dishFilter.PageSize, DbType.Int32);
                    parameters.Add("@TotalRecords", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    var dishes = await connection.QueryAsync<Dish>(
                          "GetAllDishes",
                          parameters,
                          commandType: CommandType.StoredProcedure
                      );
                    var totalRecords = parameters.Get<int>("@TotalRecords");


                    var dishDtoList = _mapper.Map<List<GetAllDishDto>>(dishes);
                    var paginatedResponse = new PagedResponse<List<GetAllDishDto>>
                    (
                        dishDtoList, dishFilter.PageNumber, dishFilter.PageSize, "Retrieved data with PageNumber:" + dishFilter.PageNumber, null, true
                    )
                    {
                        TotalRecords = totalRecords
                    };
                    return Ok(paginatedResponse);
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpGet("TopDishes")]
        public async Task<IActionResult> GetTopDishes([FromQuery] TopDishBodyRequestDto topDishBodyRequestDto)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@BranchId", topDishBodyRequestDto.BranchId, DbType.Guid);
                    parameters.Add("@StartDate", topDishBodyRequestDto.StartDate, DbType.Date);
                    parameters.Add("@EndDate", topDishBodyRequestDto.EndDate, DbType.Date);
                    parameters.Add("@mode", 1, DbType.Int16);
                    var dishes = await connection.QueryAsync<TopDishDto>(
                          "PD_DISH_STATISTICS",
                            parameters,
                          commandType: CommandType.StoredProcedure
                      );
                    return Ok(new Response<List<TopDishDto>>(dishes.ToList(), "Top Dishes"));
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


              [HttpGet("WorstDishes")]
        public async Task<IActionResult> WorstDishes([FromQuery] TopDishBodyRequestDto topDishBodyRequestDto)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@BranchId", topDishBodyRequestDto.BranchId, DbType.Guid);
                    parameters.Add("@StartDate", topDishBodyRequestDto.StartDate, DbType.Date);
                    parameters.Add("@EndDate", topDishBodyRequestDto.EndDate, DbType.Date);
                    parameters.Add("@mode", 2, DbType.Int16);
                    var dishes = await connection.QueryAsync<TopDishDto>(
                          "PD_DISH_STATISTICS",
                            parameters,
                          commandType: CommandType.StoredProcedure
                      );
                    return Ok(new Response<List<TopDishDto>>(dishes.ToList(), "Top Dishes"));
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}

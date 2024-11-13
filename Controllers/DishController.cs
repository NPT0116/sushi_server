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
                    parameters.Add("@PageNumber", dishFilter.PageNumber, DbType.Int32);
                    parameters.Add("@PageSize", dishFilter.PageSize, DbType.Int32);

                  var dishes = await connection.QueryAsync<Dish> (
                        "GetAllDishes",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );
                    var totalRecords = await connection.ExecuteScalarAsync<int>(
                        @"SELECT COUNT(1) 
                        FROM Dishes 
                        WHERE (@DishName IS NULL OR DishName LIKE @DishName + '%')
                        AND (@MinPrice IS NULL OR CurrentPrice >= @MinPrice)
                        AND (@MaxPrice IS NULL OR CurrentPrice <= @MaxPrice)",
                        parameters
                    );

                    var dishDtoList = _mapper.Map<List<GetAllDishDto>>(dishes);
                    var paginatedResponse = new PagedResponse<List<GetAllDishDto>>
                    (
                        dishDtoList, dishFilter.PageNumber,dishFilter.PageSize, "Retrieved data with PageNumber:" + dishFilter.PageNumber, null, true
                    );
                    return Ok(paginatedResponse);
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}

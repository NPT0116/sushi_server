using System;
using System.Data;
using AutoMapper;
using Dapper;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Dto.Employee;
using sushi_server.Filters;
using sushi_server.Helper;
using sushi_server.Models;

namespace sushi_server.Controllers;

[Route("api/employee")]
[ApiController]
public class EmployeeController : ControllerBase
{
    private readonly SushiDbContext _context;
    private readonly IMapper _mapper;
    public EmployeeController(SushiDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    [HttpGet]

    public async Task<IActionResult> GetAll([FromQuery] EmployeeFilter employeeFilter)
    {
        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("@BranchId", employeeFilter.BranchId, DbType.Guid);
                parameters.Add("@DepartmentId", employeeFilter.DepartmentId, DbType.Guid);
                parameters.Add("@Name", employeeFilter.Name, DbType.String);
                parameters.Add("@PageSize", employeeFilter.PageSize, DbType.Int32);
                parameters.Add("@PageNumber", employeeFilter.PageNumber, DbType.Int32);
                parameters.Add("@TotalRecord", dbType: DbType.Int32, direction: ParameterDirection.Output);


                var employeeDto = await connection.QueryAsync<EmployeeGetAllDto>(
                    "getallemployees",
                     parameters,
                      commandType: CommandType.StoredProcedure
                );
                var employeeDtoList = employeeDto.ToList();
                var totalRecords = parameters.Get<int>("@TotalRecord");
                var paginatedResponse = new PagedResponse<List<EmployeeGetAllDto>>(employeeDtoList, employeeFilter.PageNumber,
                employeeFilter.PageSize,
                "Retrieved data with PageNumber:" + employeeFilter.PageNumber, null, true
                )
                {
                    TotalRecords = totalRecords
                };
                return Ok(paginatedResponse);
            };
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }

}

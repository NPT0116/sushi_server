using System;
using System.Data;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Models;
using sushi_server.Dto.Branch;
using sushi_server.Helper;
using sushi_server.Data;

namespace sushi_server.Controllers;

[Route("api/branch")]
[ApiController]
public class BranchController : ControllerBase
{
    private readonly SushiDbContext _context;
    private readonly IMapper _mapper;
    public BranchController(SushiDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    [HttpGet("get-all/branch-name")]
    public async Task<IActionResult> GetAllBranchName()
    {
        try
        {
            var branches = await _context.Branches
                .OrderBy(b => b.Name)
                .ProjectTo<BranchName>(_mapper.ConfigurationProvider)
                .ToListAsync();
            
            return Ok(new Response<List<BranchName>>(branches, "Retrieved branch name and branch id in alphabetical order"));
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    [HttpGet("get-detail-branch")]
    public async Task<IActionResult> GetBranchDetail()
    {
        try
        {
            var branches = await _context.Branches
                .OrderBy(b => b.Name)
                .ProjectTo<BranchDetail>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return Ok(new Response<List<BranchDetail>>(branches, "Retrieved branch with detail data "));
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }



    [HttpGet("get-daily-revenue")]
    public async Task<IActionResult> GetDailyRevenue([FromQuery] Guid branchId, [FromQuery] DateTime date)
    {
        if (branchId == Guid.Empty || date == null)
        {
            return BadRequest("BranchId and Date are required.");
        }

        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@BranchId", branchId, DbType.Guid);
                parameters.Add("@Date", date.Date, DbType.Date);

                // Gọi stored procedure để lấy doanh thu trong ngày của cửa hàng
                var result = await connection.QueryFirstOrDefaultAsync<RevenueDto>(
                    "GetDailyRevenueByBranch", // Tên stored procedure
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                if (result == null)
                {
                    return NotFound("No revenue data found for this branch and date.");
                }

                return Ok(new Response<RevenueDto>(result, "Retrieved daily revenue successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }

    [HttpGet("get-revenue-by-date-range")]
    public async Task<IActionResult> GetRevenueByDateRange([FromQuery] Guid branchId, [FromQuery] DateTime startDate, [FromQuery] DateTime endDate)
    {
        if (branchId == Guid.Empty || startDate == null || endDate == null)
        {
            return BadRequest("BranchId, StartDate, and EndDate are required.");
        }

        try
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@BranchId", branchId, DbType.Guid);
                parameters.Add("@StartDate", startDate.Date, DbType.Date);
                parameters.Add("@EndDate", endDate.Date, DbType.Date);

                // Gọi stored procedure để lấy doanh thu trong khoảng thời gian của cửa hàng
                var result = await connection.QueryAsync<RevenueDto>(
                    "GetRevenueByDateRangeForBranch", // Tên stored procedure
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                if (result == null || !result.Any())
                {
                    return NotFound("No revenue data found for this branch and date range.");
                }
                foreach (var item in result)
                {
                    item.RevenueDate = item.RevenueDate.Date;  // Chuyển chỉ lấy phần ngày
                }


                return Ok(new Response<List<RevenueDto>>(result.ToList(), "Retrieved revenue data for the date range successfully."));
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return StatusCode(500, "Internal server error");
        }
    }

}

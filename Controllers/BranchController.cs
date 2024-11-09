using System;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.Branch;
using sushi_server.Helper;

namespace sushi_server.Controllers;

[Route("api/branch")]
[ApiController]
public class BranchController: ControllerBase
{
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public BranchController(ApplicationDbContext context, IMapper mapper)
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
}

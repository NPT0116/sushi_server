using System;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.Section;
using sushi_server.Helper;

namespace sushi_server.Controllers
{
    [Route("/api/section")]
    [ApiController]
    public class SectionController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public SectionController(ApplicationDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var sections = await _context.Sections.ProjectTo<SectionGetAll>(_mapper.ConfigurationProvider).ToListAsync() ;
                return Ok(new Response<List<SectionGetAll>>(sections, "Retrieved full section successfully")); 
            }
            catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}


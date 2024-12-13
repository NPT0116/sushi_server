using System;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
 
using sushi_server.Dto;
using sushi_server.Dto.TableDetail;
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

    
    }
}
using System;
using AutoMapper;
using Azure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using sushi_server.Data;
using sushi_server.Dto.BranchDishes;

namespace sushi_server.Controllers;

[Route("api/branch-dish")]
public class BranchDishesController: ControllerBase
{
            private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public BranchDishesController(ApplicationDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet("status/{DishId}/{BranchId}")]

        public async Task<IActionResult> GetStatus([FromRoute] Guid DishId, [FromRoute] Guid BranchId )
        {
            try
            {
            Console.WriteLine(DishId);
            Console.WriteLine(BranchId);
            var branchDishesStatus =  await _context.BranchDishes.Where(bd => bd.BranchId == BranchId && bd.DishId == DishId).FirstOrDefaultAsync();
            if (branchDishesStatus != null)
            {
                var branchDishesStatusDto = _mapper.Map<BranchDishesDto> (branchDishesStatus);
                return Ok(new Helper.Response<BranchDishesDto>(branchDishesStatusDto));
            }
            else{
                return BadRequest("can't find BranchDish with dishId and BranchId");
            }
            }
            catch( Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }
}

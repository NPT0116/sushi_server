using System;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using sushi_server.Data;

namespace sushi_server.Controllers;

[Route("api/employee")]
[ApiController]
public class EmployeeController
{
    private readonly ApplicationDbContext _context;
    private readonly IMapper _mapper;
    public EmployeeController(ApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }
}

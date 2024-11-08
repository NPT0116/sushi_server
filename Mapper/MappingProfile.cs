using System;
using AutoMapper;
using sushi_server.Dto.Dish;
using sushi_server.Dto.Section;
using sushi_server.Models;

namespace sushi_server.Mapper;

public class MappingProfile: Profile
{
    public MappingProfile()
    {
        CreateMap<Dish, GetAllDishDto>();
        CreateMap<Section, SectionGetAll>();
    }
}

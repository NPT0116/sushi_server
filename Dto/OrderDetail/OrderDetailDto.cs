using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.OrderDetail
{
    public class OrderDetailDto
    {
        public Guid OrderDishId { get; set; }
        public long Price { get; set; }
        public long Quantity { get; set; }
        public Guid DishId { get; set; }
        public String DishName { get; set; }
    }
}
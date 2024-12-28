using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.OrderDetail
{
    public class OrderDetailDishDto
    {
            public Guid DishId { get; set; }
        public string DishName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
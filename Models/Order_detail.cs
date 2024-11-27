using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class OrderDetail
    {
        [Key]
        public Guid Id { get; set; }
        public required OrderStatus Status { get; set; }
        public long Price { get; set; }
        public long Quantity { get; set; }
        public Guid DishId { get; set; }
        public Guid OrderId { get; set; }
        
        public required Order Order { get; set; }
    }
}


using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class Order
    {
        [Key]
        public int Id { get; set; }
        public long Total { get; set; }
        public DateTime LastModified { get; set; }
        public OrderStatus Status { get; set; }

    }
}

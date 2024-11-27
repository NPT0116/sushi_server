using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class Order
    {
        [Key]
        public Guid Id { get; set; }
        public long Total { get; set; }
        public DateTime? LastModified { get; set; }
        public required OrderStatus Status { get; set; }
        public Reservation? Reservation { get; set; }
        public required ICollection<OrderDetail> OrderDetails { get; set; }

    }
}

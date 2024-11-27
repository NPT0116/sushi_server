using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using sushi_server.Dto.Order;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class Order
    {
       [Key]
        public Guid Id { get; set; }
        public long Total { get; set; }
        public DateTime LastModified { get; set; }
        [JsonIgnore]
        public required OrderStatus Status { get; set; }
        [JsonIgnore]
        public Reservation? Reservation { get; set; }

        public required List<OrderDetail> OrderDetails { get; set; }

        public OrderResponseDTO ToResponseDTO() {
            OrderResponseDTO response =
            new OrderResponseDTO
            {
                Id = this.Id,
                Total = this.Total,
                LastModified = this.LastModified,
                Status = this.Status.ToString(),
                OrderDetails = OrderDetails.Select(od => od.toResponseDTO()).ToList()
            };
            return response;
        }
    }
}

using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using sushi_server.Dto.Order;
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
        [JsonIgnore]
        public Guid OrderId { get; set; }
        public Order Order { get; set; }

        public OrderDetailResponseDTO toResponseDTO() {
            return new OrderDetailResponseDTO
            {
                Id = this.Id,
                Status = this.Status.ToString(),
                Price = this.Price,
                Quantity = this.Quantity,
                DishId = this.DishId
            };
        }
    }
}


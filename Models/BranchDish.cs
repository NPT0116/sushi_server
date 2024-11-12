using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class BranchDish
    {
        [Key]
        public Guid BranchDishId { get; set; }

        [Required]
        public Guid BranchId { get; set; }
        public  Branch? Branch { get; set; }  // Khóa ngoại liên kết đến bảng Branch

        [Required]
        public Guid DishId { get; set; }
        public  Dish? Dish { get; set; }  // Khóa ngoại liên kết đến bảng Dish

        public bool Status { get; set; }
        public bool ShipStatus { get; set; }
    }
}

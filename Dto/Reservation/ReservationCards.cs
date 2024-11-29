using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using sushi_server.Dto.OrderDetail;

namespace sushi_server.Dto.Reservation
{
    public class ReservationCards
    {
        public Guid ReservationId { get; set; }
        public Guid CustomerId { get; set; }
        public String CustomerName { get; set; } = string.Empty;
        public Guid BranchId  { get; set; }
        public String BranchName  { get; set; } = string.Empty;
        public int Status { get; set; }
        public DateTime DatedOn { get; set; }
        public int TableNumber { get; set; }
        public int TotalPeople { get; set; }
        public long TotalPrice { get; set; }
        public Guid OrderId { get; set; }
        public List<OrderDetailDto>? OrderDetails { get; set; }

    }
}
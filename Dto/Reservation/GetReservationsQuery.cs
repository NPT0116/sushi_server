using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.Reservation
{
    public class GetReservationsQuery
    {
        public Guid? BranchId { get; set; }
        public DateTime? DatedOn { get; set; }
    }
}
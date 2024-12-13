using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Models
{
    public class AccessHistory
    {
        public Guid Id { get; set; }
        public Guid CustomerId { get; set; }
        public Customer? Customer { get; set; }
        public DateTime AccessTime { get; set; }
        public int Duration { get; set; }
    }
}
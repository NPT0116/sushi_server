using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sushi_server.Dto.Customers
{
public class CustomerDto
    {
        public Guid CustomerId { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public List<CardDto> Cards { get; set; }
    }

    public class CardDto
    {
        public Guid CardId { get; set; }
        public string CardNumber { get; set; }
        public RankingDto Ranking { get; set; }
    }

    public class RankingDto
    {
        public int RankingId { get; set; }
        public string RankName { get; set; }
    }
}
using System.ComponentModel.DataAnnotations.Schema;

namespace sushi_server.Models
{
    public class Card
    {
        public Guid CardId { get; set; }
        public DateTime StartDate { get; set; }
        public float AccumulatedPoints { get; set; }
        public bool Valid { get; set; }
        public DateTime? AccumulatedDate { get; set; }

        public Guid EmployeeId { get; set; }
        public Employee? Employee { get; set; }
        
        [ForeignKey("Ranking")]  // Specify that RankingId is a foreign key to Ranking

        public int RankingId { get; set; }
        public Ranking? Ranking { get; set; }
        public Guid CustomerId { get; set; }
        public Customer  Customer { get; set; }
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace sushi_server.Models
{
    public class Card
    {
        public Guid CardId { get; set; } // Sử dụng GUID thay vì int với IDENTITY

        public DateTime StartDate { get; set; }
        public float AccumulatedPoints { get; set; }
        public bool Valid { get; set; }
        public DateTime? AccumulatedDate { get; set; }

        public Guid EmployeeId { get; set; }
        public Employee? Employee { get; set; }

        public int RankingId { get; set; }
        public Ranking? Ranking { get; set; }
        public Guid CustomerId { get; set; }
        public required Customer Customer { get; set; }
    }
}

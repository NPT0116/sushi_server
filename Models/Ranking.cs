using System.ComponentModel.DataAnnotations;

namespace sushi_server.Models
{
    public class Ranking
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public int RequirePoint { get; set; }
        public int Discount { get; set; }
        public int UpgradePoint { get; set; }

    }
}

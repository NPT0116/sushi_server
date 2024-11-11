using System.ComponentModel.DataAnnotations;
using sushi_server.Models.Enum;
namespace sushi_server.Models
{
    public class TableDetail
    {
        [Key]
        public int Id { get; set; }
        public int MaxPeople { get; set; }
        public TableStatus tableStatus { get; set; }
    }
}

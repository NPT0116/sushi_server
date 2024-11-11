namespace sushi_server.Models
{
    public class Card
    {
        public int Id { get; set; }
        public DateTime StartDate { get; set; }
        public float AccumulatedPoints { get; set; }
        public bool Valid { get; set; }
        public DateTime? AccumulatedDate { get; set; }

    }
}

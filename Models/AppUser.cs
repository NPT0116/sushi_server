using System;
using Microsoft.AspNetCore.Identity;

namespace sushi_server.Models
{
    public class AppUser : IdentityUser
    {
        // Thuộc tính tham chiếu đến Customer
        public Guid? CustomerId { get; set; }
        
        // Thuộc tính liên kết với Customer
        public Customer? Customer { get; set; }
    }
}

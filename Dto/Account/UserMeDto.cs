using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Account;

public class UserMeDto
{
    public Guid CustomerId { get; set; }
    public string UserName { get; set; }
    public string Name { get; set; }
    public string Phone { get; set; }
<<<<<<< HEAD
    public string Rank { get; set; }
    public int Point { get; set; }
=======
>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e

    // Employee-specific properties

}

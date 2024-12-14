using System;
using System.ComponentModel.DataAnnotations;

namespace sushi_server.Dto.Account;

public class UserMeDto
{
    public Guid CustomerId { get; set; }
    public string UserName { get; set; }
    public string Name { get; set; }
    public string Phone { get; set; }

    // Employee-specific properties

}

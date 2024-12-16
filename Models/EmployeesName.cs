using System;
using System.Collections.Generic;
<<<<<<< HEAD
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

[Table("employeesName")]
public partial class EmployeesName
{
    [Key]
    [Column("id")]
    public Guid Id { get; set; }

    [Column("name")]
    [StringLength(50)]
=======

namespace sushi_server.Models;

public partial class EmployeesName
{
    public Guid Id { get; set; }

>>>>>>> 6391f7d9672413a1dd0fece5e89d71524114e14e
    public string? Name { get; set; }
}

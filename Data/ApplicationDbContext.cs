using System;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using sushi_server.Models;

namespace sushi_server.Data;

public class ApplicationDbContext: IdentityDbContext<AppUser>
{
    public ApplicationDbContext(DbContextOptions dbContextOptions) : base(dbContextOptions)
    {
        
    }
    public DbSet<Customer>  Customers { get; set; }   
    public DbSet<Section> Sections { get; set; }
    public DbSet<Dish> Dishes { get; set; }
    public DbSet<Branch> Branches { get; set; }
    public DbSet<TableDetail> TableDetail { get; set; }
    public DbSet<BranchDish> BranchDishes { get; set; }
    public DbSet<Employee> Employees { get; set; }
    public DbSet<Department> Departments { get; set; }
    public DbSet<Ranking> Rankings { get; set; }
    public DbSet<Card> Cards { get; set; }
    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        List<IdentityRole> roles = new List<IdentityRole>{
            new IdentityRole {
                Name = "User",
                NormalizedName = "USER"
            },
            new IdentityRole{
                Name = "Admin",
                NormalizedName = "ADMIN"
            },
            new IdentityRole {
                Name = "Emp",
                NormalizedName = "EMP"
            }
        };
        builder.Entity<IdentityRole>().HasData(roles);

        // SectionName unique
        builder.Entity<Section>()
        .HasIndex(s => s.SectionName)
        .IsUnique();
         builder.Entity<TableDetail>()
                .HasIndex(t => new { t.BranchId, t.TableNumber })
                .IsUnique(); // Tạo index duy nhất trên BranchId và
    }
}

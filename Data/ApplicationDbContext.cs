using System;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using sushi_server.Models;

namespace sushi_server.Data;

public class ApplicationDbContext : IdentityDbContext<AppUser>
{
    public ApplicationDbContext(DbContextOptions dbContextOptions) : base(dbContextOptions)
    {

    }
    public DbSet<Customer> Customers { get; set; }
    public DbSet<Section> Sections { get; set; }
    public DbSet<Dish> Dishes { get; set; }
    public DbSet<Branch> Branches { get; set; }
    public DbSet<TableDetail> TableDetail { get; set; }
    public DbSet<BranchDish> BranchDishes { get; set; }
    public DbSet<Employee> Employees { get; set; }
    public DbSet<Department> Departments { get; set; }
    public DbSet<Ranking> Rankings { get; set; }
    public DbSet<Card> Cards { get; set; }
    public DbSet<Invoice> Invoices { get; set; }
    public DbSet<Order> Orders { get; set; }
    public DbSet<Reservation> Reservation { get; set; }
    public DbSet<WorkHistory> WorkHistories { get; set; }
    public DbSet<WorkHistory> WorkHistory { get; set; }
    public DbSet<Survey> Surveys { get; set; }
    public DbSet<AccessHistory> AccessHistories { get; set; }
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
    builder.Entity<Invoice>()
            .HasOne(i => i.Survey)
            .WithOne(s => s.Invoice)
            .HasForeignKey<Survey>(s => s.InvoiceId)
            .OnDelete(DeleteBehavior.Restrict); // Specify OnDelete behavior

        // Configure the WorkHistory-Employee relationship
        builder.Entity<WorkHistory>()
            .HasOne(w => w.Employee)
            .WithMany(e => e.WorkHistories)
            .HasForeignKey(w => w.EmployeeId)
            .OnDelete(DeleteBehavior.NoAction); // Specify OnDelete behavior


    }
}
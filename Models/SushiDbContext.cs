using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace sushi_server.Models;

public partial class SushiDbContext : DbContext
{
    public SushiDbContext()
    {
    }

    public SushiDbContext(DbContextOptions<SushiDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AccessHistory> AccessHistories { get; set; }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Branch> Branches { get; set; }

    public virtual DbSet<BranchDish> BranchDishes { get; set; }

    public virtual DbSet<Card> Cards { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Department> Departments { get; set; }

    public virtual DbSet<Dish> Dishes { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<EmployeesName> EmployeesNames { get; set; }

    public virtual DbSet<Invoice> Invoices { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Ranking> Rankings { get; set; }

    public virtual DbSet<Reservation> Reservations { get; set; }

    public virtual DbSet<Section> Sections { get; set; }

    public virtual DbSet<Survey> Surveys { get; set; }

    public virtual DbSet<TableDetail> TableDetails { get; set; }

    public virtual DbSet<WorkHistory> WorkHistories { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AccessHistory>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Customer).WithMany(p => p.AccessHistories).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Account>(entity =>
        {
            entity.Property(e => e.Id).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Customer).WithMany(p => p.Accounts).HasConstraintName("FK_Account_Customer_CustomerId");

            entity.HasOne(d => d.Employee).WithMany(p => p.Accounts).HasConstraintName("FK_Account_Employee_EmployeeId");
        });

        modelBuilder.Entity<Branch>(entity =>
        {
            entity.Property(e => e.BranchId).ValueGeneratedNever();
        });

        modelBuilder.Entity<BranchDish>(entity =>
        {
            entity.Property(e => e.BranchDishId).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.BranchDishes).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Dish).WithMany(p => p.BranchDishes).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Card>(entity =>
        {
            entity.ToTable(tb =>
                {
                    tb.HasTrigger("trg_DemoteCustomerCard");
                    tb.HasTrigger("trg_UpdateCustomerCardRank");
                });

            entity.HasOne(d => d.Customer).WithMany(p => p.Cards).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Employee).WithMany(p => p.Cards).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Ranking).WithMany(p => p.Cards).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.Property(e => e.CustomerId).ValueGeneratedNever();
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.Property(e => e.DepartmentId).ValueGeneratedNever();
        });

        modelBuilder.Entity<Dish>(entity =>
        {
            entity.Property(e => e.DishId).ValueGeneratedNever();

            entity.HasOne(d => d.Section).WithMany(p => p.Dishes).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.Employees).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Department).WithMany(p => p.Employees).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<EmployeesName>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__employee__3213E83F31C2EB99");

            entity.Property(e => e.Id).ValueGeneratedNever();
        });

        modelBuilder.Entity<Invoice>(entity =>
        {
            entity.Property(e => e.Id).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Branch).WithMany(p => p.Invoices)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Invoices_Branch_BranchId");

            entity.HasOne(d => d.Order).WithMany(p => p.Invoices).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.ToTable("OrderDetail", tb => tb.HasTrigger("trg_UpdateOrderTotal"));

            entity.Property(e => e.Id).ValueGeneratedNever();
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.Reservations)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Reservation_Branch_BranchId");
        });

        modelBuilder.Entity<Section>(entity =>
        {
            entity.Property(e => e.SectionId).ValueGeneratedNever();
        });

        modelBuilder.Entity<Survey>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Invoice).WithOne(p => p.Survey).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<TableDetail>(entity =>
        {
            entity.Property(e => e.TableId).ValueGeneratedNever();
        });

        modelBuilder.Entity<WorkHistory>(entity =>
        {
            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.WorkHistories).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Department).WithMany(p => p.WorkHistories).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Employee).WithMany(p => p.WorkHistories).OnDelete(DeleteBehavior.ClientSetNull);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

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


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AccessHistory>(entity =>
        {
            entity.HasIndex(e => e.CustomerId, "IX_AccessHistories_CustomerId");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Customer).WithMany(p => p.AccessHistories)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Account>(entity =>
        {
            entity.ToTable("Account");

            entity.HasIndex(e => e.Username, "UQ__Account__536C85E420224382").IsUnique();

            entity.Property(e => e.Id).ValueGeneratedNever();
            entity.Property(e => e.Password)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Username)
                .HasMaxLength(10)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.Accounts)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_Account_Customer_CustomerId");

            entity.HasOne(d => d.Employee).WithMany(p => p.Accounts)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_Account_Employee_EmployeeId");
        });

        modelBuilder.Entity<Branch>(entity =>
        {
            entity.Property(e => e.BranchId).ValueGeneratedNever();
            entity.Property(e => e.Address).HasMaxLength(200);
            entity.Property(e => e.Name).HasMaxLength(100);

            entity.HasOne(d => d.Manager).WithMany(p => p.Branches).HasForeignKey(d => d.ManagerId);
        });

        modelBuilder.Entity<BranchDish>(entity =>
        {
            entity.HasIndex(e => e.BranchId, "IX_BranchDishes_BranchId");

            entity.HasIndex(e => e.DishId, "IX_BranchDishes_DishId");

            entity.Property(e => e.BranchDishId).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.BranchDishes)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Dish).WithMany(p => p.BranchDishes)
                .HasForeignKey(d => d.DishId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Card>(entity =>
        {
            entity.ToTable(tb =>
                {
                    tb.HasTrigger("trg_DemoteCustomerCard");
                    tb.HasTrigger("trg_UpdateCustomerCardRank");
                });

            entity.HasOne(d => d.Customer).WithMany(p => p.Cards)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Employee).WithMany(p => p.Cards)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Ranking).WithMany(p => p.Cards)
                .HasForeignKey(d => d.RankingId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.Property(e => e.CustomerId).ValueGeneratedNever();
            entity.Property(e => e.CitizenId).HasMaxLength(20);
            entity.Property(e => e.Name).HasMaxLength(100);
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.Property(e => e.DepartmentId).ValueGeneratedNever();
        });

        modelBuilder.Entity<Dish>(entity =>
        {
            entity.HasIndex(e => e.SectionId, "IX_Dishes_SectionId");

            entity.Property(e => e.DishId).ValueGeneratedNever();

            entity.HasOne(d => d.Section).WithMany(p => p.Dishes)
                .HasForeignKey(d => d.SectionId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasIndex(e => e.BranchId, "IX_Employees_BranchId");

            entity.HasIndex(e => e.DepartmentId, "IX_Employees_DepartmentId");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.Employees)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Department).WithMany(p => p.Employees)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<EmployeesName>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__employee__3213E83F4C2112DB");

            entity.ToTable("employeesName");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Invoice>(entity =>
        {
            entity.HasIndex(e => new { e.Paid, e.BranchId, e.DatedOn }, "IDX_Invoices_Paid_BranchId_DatedOn");

            entity.HasIndex(e => e.OrderId, "IX_Invoices_OrderId");

            entity.Property(e => e.Id).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Branch).WithMany(p => p.Invoices)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Invoices_Branch_BranchId");

            entity.HasOne(d => d.Order).WithMany(p => p.Invoices)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasIndex(e => e.ReservationId, "IX_Orders_ReservationId");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Reservation).WithMany(p => p.Orders).HasForeignKey(d => d.ReservationId);
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.ToTable("OrderDetail", tb => tb.HasTrigger("trg_UpdateOrderTotal"));

            entity.HasIndex(e => e.OrderId, "IX_OrderDetail_OrderId");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails).HasForeignKey(d => d.OrderId);
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.ToTable("Reservation");

            entity.HasIndex(e => new { e.DatedOn, e.BranchId }, "IX_Reservation_DatedOn_BranchId");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Reservation_Branch_BranchId");

            entity.HasOne(d => d.Table).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.TableId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Section>(entity =>
        {
            entity.Property(e => e.SectionId).ValueGeneratedNever();
        });

        modelBuilder.Entity<Survey>(entity =>
        {
            entity.HasIndex(e => e.InvoiceId, "IX_Surveys_InvoiceId").IsUnique();

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Invoice).WithOne(p => p.Survey)
                .HasForeignKey<Survey>(d => d.InvoiceId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<TableDetail>(entity =>
        {
            entity.HasKey(e => e.TableId);

            entity.ToTable("TableDetail");

            entity.Property(e => e.TableId).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.TableDetails).HasForeignKey(d => d.BranchId);
        });

        modelBuilder.Entity<WorkHistory>(entity =>
        {
            entity.ToTable("WorkHistory");

            entity.Property(e => e.Id).ValueGeneratedNever();

            entity.HasOne(d => d.Branch).WithMany(p => p.WorkHistories)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Department).WithMany(p => p.WorkHistories)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Employee).WithMany(p => p.WorkHistories)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

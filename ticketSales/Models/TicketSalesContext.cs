using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ticketSales.Models
{
    public partial class TicketSalesContext : DbContext
    {
        public TicketSalesContext()
        {
        }

        public TicketSalesContext(DbContextOptions<TicketSalesContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Buses> Buses { get; set; }
        public virtual DbSet<Expeditions> Expeditions { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<Routes> Routes { get; set; }
        public virtual DbSet<Tickets> Tickets { get; set; }
        public virtual DbSet<UserRole> UserRole { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=.;Database=TicketSales;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Buses>(entity =>
            {
                entity.ToTable("buses");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Plaque)
                    .IsRequired()
                    .HasColumnName("plaque")
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<Expeditions>(entity =>
            {
                entity.ToTable("expeditions");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.BusId).HasColumnName("bus_id");

                entity.Property(e => e.Date)
                    .HasColumnName("date")
                    .HasColumnType("date");

                entity.Property(e => e.Price).HasColumnName("price");

                entity.Property(e => e.RouteId).HasColumnName("route_id");

                entity.Property(e => e.Time).HasColumnName("time");

                entity.HasOne(d => d.Bus)
                    .WithMany(p => p.Expeditions)
                    .HasForeignKey(d => d.BusId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_expeditions_buses");

                entity.HasOne(d => d.Route)
                    .WithMany(p => p.Expeditions)
                    .HasForeignKey(d => d.RouteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_expeditions_routes");
            });

            modelBuilder.Entity<Roles>(entity =>
            {
                entity.ToTable("roles");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(20);
            });

            modelBuilder.Entity<Routes>(entity =>
            {
                entity.ToTable("routes");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Arrival)
                    .HasColumnName("arrival")
                    .HasMaxLength(20);

                entity.Property(e => e.Departure)
                    .IsRequired()
                    .HasColumnName("departure")
                    .HasMaxLength(20);
            });

            modelBuilder.Entity<Tickets>(entity =>
            {
                entity.ToTable("tickets");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.ExpeditionId).HasColumnName("expedition_id");

                entity.Property(e => e.SeatNumber).HasColumnName("seatNumber");

                entity.Property(e => e.Status).HasColumnName("status");

                entity.Property(e => e.TicketPrice).HasColumnName("ticketPrice");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.HasOne(d => d.Expedition)
                    .WithMany(p => p.Tickets)
                    .HasForeignKey(d => d.ExpeditionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tickets_expeditions");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Tickets)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tickets_users");
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.ToTable("userRole");

                entity.Property(e => e.UserRoleId).HasColumnName("userRole_id");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.UserRole)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_userRole_roles");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserRole)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_userRole_users");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.ToTable("users");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasColumnName("email")
                    .HasMaxLength(50);

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasColumnName("password")
                    .HasMaxLength(10);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasColumnName("user_name")
                    .HasMaxLength(20);

                entity.Property(e => e.UserSurname)
                    .IsRequired()
                    .HasColumnName("user_surname")
                    .HasMaxLength(20);
            });
        }
    }
}

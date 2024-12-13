using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class access_history : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "25fe407d-d033-4811-882e-12481f211111");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "81171e6f-9d17-49da-b22f-678485bdf810");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ecb587c4-5c56-4693-b5e1-b5570e124ff3");

            migrationBuilder.CreateTable(
                name: "AccessHistories",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CustomerId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    AccessTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Duration = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AccessHistories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AccessHistories_Customers_CustomerId",
                        column: x => x.CustomerId,
                        principalTable: "Customers",
                        principalColumn: "CustomerId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5c209329-5937-4dad-b120-a3e387879428", null, "Admin", "ADMIN" },
                    { "656fc797-632d-4225-b4ae-afce5869ed33", null, "Emp", "EMP" },
                    { "ecbafc2b-47e5-40d3-a616-b74d7a79c27c", null, "User", "USER" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_AccessHistories_CustomerId",
                table: "AccessHistories",
                column: "CustomerId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AccessHistories");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5c209329-5937-4dad-b120-a3e387879428");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "656fc797-632d-4225-b4ae-afce5869ed33");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ecbafc2b-47e5-40d3-a616-b74d7a79c27c");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "25fe407d-d033-4811-882e-12481f211111", null, "Admin", "ADMIN" },
                    { "81171e6f-9d17-49da-b22f-678485bdf810", null, "User", "USER" },
                    { "ecb587c4-5c56-4693-b5e1-b5570e124ff3", null, "Emp", "EMP" }
                });
        }
    }
}

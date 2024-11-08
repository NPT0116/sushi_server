using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class AddDishAndSection : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1c5919fc-f5a8-4376-9b51-60f946badbb7");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "540e009f-a649-4799-864a-1b87d0019124");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "c11b643c-ae67-4dd3-91a5-9a1d46e13531");

            migrationBuilder.CreateTable(
                name: "Sections",
                columns: table => new
                {
                    SectionId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    SectionName = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sections", x => x.SectionId);
                });

            migrationBuilder.CreateTable(
                name: "Dishes",
                columns: table => new
                {
                    DishId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DishName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CurrentPric = table.Column<int>(type: "int", nullable: false),
                    SectionId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Dishes", x => x.DishId);
                    table.ForeignKey(
                        name: "FK_Dishes_Sections_SectionId",
                        column: x => x.SectionId,
                        principalTable: "Sections",
                        principalColumn: "SectionId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "9417ca04-89eb-41a4-ab9c-30096214e787", null, "Emp", "EMP" },
                    { "a0312133-5a86-46cb-b589-448f7f74f2fe", null, "User", "USER" },
                    { "d328656b-580e-4a2f-8ebe-cd978e542fd9", null, "Admin", "ADMIN" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Dishes_SectionId",
                table: "Dishes",
                column: "SectionId");

            migrationBuilder.CreateIndex(
                name: "IX_Sections_SectionName",
                table: "Sections",
                column: "SectionName",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Dishes");

            migrationBuilder.DropTable(
                name: "Sections");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9417ca04-89eb-41a4-ab9c-30096214e787");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "a0312133-5a86-46cb-b589-448f7f74f2fe");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "d328656b-580e-4a2f-8ebe-cd978e542fd9");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "1c5919fc-f5a8-4376-9b51-60f946badbb7", null, "Emp", "EMP" },
                    { "540e009f-a649-4799-864a-1b87d0019124", null, "User", "USER" },
                    { "c11b643c-ae67-4dd3-91a5-9a1d46e13531", null, "Admin", "ADMIN" }
                });
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class FixCurrentPrice : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.RenameColumn(
                name: "CurrentPric",
                table: "Dishes",
                newName: "CurrentPrice");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "1f0babb8-709b-4748-81b5-bbb882f3c2f7", null, "Admin", "ADMIN" },
                    { "a6007636-8569-4d3a-bec7-ddb386de1a50", null, "User", "USER" },
                    { "e935b6af-6203-49d1-9a8d-b908239de557", null, "Emp", "EMP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1f0babb8-709b-4748-81b5-bbb882f3c2f7");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "a6007636-8569-4d3a-bec7-ddb386de1a50");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e935b6af-6203-49d1-9a8d-b908239de557");

            migrationBuilder.RenameColumn(
                name: "CurrentPrice",
                table: "Dishes",
                newName: "CurrentPric");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "9417ca04-89eb-41a4-ab9c-30096214e787", null, "Emp", "EMP" },
                    { "a0312133-5a86-46cb-b589-448f7f74f2fe", null, "User", "USER" },
                    { "d328656b-580e-4a2f-8ebe-cd978e542fd9", null, "Admin", "ADMIN" }
                });
        }
    }
}

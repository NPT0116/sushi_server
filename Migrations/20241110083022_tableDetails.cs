using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class tableDetails : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5133e80b-fde6-4dcd-bcaf-d22600b825c9");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "702d2f8a-a71f-4677-88af-23bd5a9edcb9");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "fd0448de-ac4c-4ac2-ac24-508fb30736b0");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "0dda79cd-6b23-4be3-9522-bdda21965433", null, "User", "USER" },
                    { "72810a97-9e9f-44a3-9562-169c742dd4f6", null, "Admin", "ADMIN" },
                    { "7538076f-c72b-48ea-b091-78f86aadd9d3", null, "Emp", "EMP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "0dda79cd-6b23-4be3-9522-bdda21965433");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "72810a97-9e9f-44a3-9562-169c742dd4f6");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7538076f-c72b-48ea-b091-78f86aadd9d3");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5133e80b-fde6-4dcd-bcaf-d22600b825c9", null, "Admin", "ADMIN" },
                    { "702d2f8a-a71f-4677-88af-23bd5a9edcb9", null, "Emp", "EMP" },
                    { "fd0448de-ac4c-4ac2-ac24-508fb30736b0", null, "User", "USER" }
                });
        }
    }
}

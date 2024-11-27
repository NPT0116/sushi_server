using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class AddIdentityRoles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "55b6fb40-8723-4e68-b26a-db64593bf9e1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b56c0bd5-777e-40f2-a50b-01dd84ba208c");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e5c60ce4-77a8-4e86-8f04-91fc0d7dd143");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5696c690-61c2-4ce7-83e2-da2e03cc49ff", null, "User", "USER" },
                    { "6eaddb63-1825-45cc-aed4-c7af1057c70d", null, "Emp", "EMP" },
                    { "9f7594c4-6315-4277-a07e-2b2a7a60f9f9", null, "Admin", "ADMIN" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5696c690-61c2-4ce7-83e2-da2e03cc49ff");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "6eaddb63-1825-45cc-aed4-c7af1057c70d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9f7594c4-6315-4277-a07e-2b2a7a60f9f9");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "55b6fb40-8723-4e68-b26a-db64593bf9e1", null, "Emp", "EMP" },
                    { "b56c0bd5-777e-40f2-a50b-01dd84ba208c", null, "User", "USER" },
                    { "e5c60ce4-77a8-4e86-8f04-91fc0d7dd143", null, "Admin", "ADMIN" }
                });
        }
    }
}

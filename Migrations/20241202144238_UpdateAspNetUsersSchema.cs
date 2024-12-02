using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class UpdateAspNetUsersSchema : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "0267e1ca-f6a1-48cf-9d9d-cdda0733680b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "6fe92f92-0487-4bb6-bf12-52f513968663");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "aa9dc0aa-3eb9-446c-8911-38d25468e337");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "09720374-cf90-4b38-83f3-feb9a2bd555b", null, "User", "USER" },
                    { "c46c1b64-bda0-4241-8115-774586751a81", null, "Admin", "ADMIN" },
                    { "fce46e9e-e0f7-4a6e-8940-51010de96d06", null, "Emp", "EMP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "09720374-cf90-4b38-83f3-feb9a2bd555b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "c46c1b64-bda0-4241-8115-774586751a81");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "fce46e9e-e0f7-4a6e-8940-51010de96d06");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "0267e1ca-f6a1-48cf-9d9d-cdda0733680b", null, "Emp", "EMP" },
                    { "6fe92f92-0487-4bb6-bf12-52f513968663", null, "Admin", "ADMIN" },
                    { "aa9dc0aa-3eb9-446c-8911-38d25468e337", null, "User", "USER" }
                });
        }
    }
}

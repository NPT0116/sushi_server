using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class customer : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "36ea4c83-5df7-4daa-98ff-3d60caa2f7ca");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "50f1a885-cb85-4a39-9e35-4e26718e6fb7");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "92fd13f0-ee4e-464a-95b2-d1ad0082bfe0");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "2c2d3887-e57f-4309-9e0a-bc400165953d", null, "Admin", "ADMIN" },
                    { "76564bfb-c0c8-479f-aa91-3ae43bc6c009", null, "Emp", "EMP" },
                    { "bba5c06b-869d-4edd-84a0-571c2afa7b38", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "2c2d3887-e57f-4309-9e0a-bc400165953d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "76564bfb-c0c8-479f-aa91-3ae43bc6c009");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "bba5c06b-869d-4edd-84a0-571c2afa7b38");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "36ea4c83-5df7-4daa-98ff-3d60caa2f7ca", null, "User", "USER" },
                    { "50f1a885-cb85-4a39-9e35-4e26718e6fb7", null, "Emp", "EMP" },
                    { "92fd13f0-ee4e-464a-95b2-d1ad0082bfe0", null, "Admin", "ADMIN" }
                });
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class BranchAndBranchDish : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "580c0605-d836-419e-a088-9e517ab5c099", null, "Admin", "ADMIN" },
                    { "7a4c8686-f411-4a4a-a1fd-1e4e55ae4530", null, "User", "USER" },
                    { "7f06f141-2bca-42d7-8d40-1189de6a4e83", null, "Emp", "EMP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "580c0605-d836-419e-a088-9e517ab5c099");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7a4c8686-f411-4a4a-a1fd-1e4e55ae4530");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7f06f141-2bca-42d7-8d40-1189de6a4e83");

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
    }
}

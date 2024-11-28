using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class latest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4f908d11-bc1e-4206-95fa-570c4b2a778d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7a626b0c-4a95-405f-9aba-de4c18d64ae4");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9c521b64-3987-4b15-9300-5699d3928106");

            migrationBuilder.AlterColumn<DateTime>(
                name: "LastModified",
                table: "Orders",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldNullable: true);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5cee2967-7fd3-4bf8-bdb1-ddb1a10a965c", null, "Emp", "EMP" },
                    { "7840cf38-8777-4205-93f2-8bc62c4a23ec", null, "Admin", "ADMIN" },
                    { "baffa4d9-bcc1-425d-9111-dc3063efd198", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5cee2967-7fd3-4bf8-bdb1-ddb1a10a965c");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7840cf38-8777-4205-93f2-8bc62c4a23ec");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "baffa4d9-bcc1-425d-9111-dc3063efd198");

            migrationBuilder.AlterColumn<DateTime>(
                name: "LastModified",
                table: "Orders",
                type: "datetime2",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "4f908d11-bc1e-4206-95fa-570c4b2a778d", null, "User", "USER" },
                    { "7a626b0c-4a95-405f-9aba-de4c18d64ae4", null, "Emp", "EMP" },
                    { "9c521b64-3987-4b15-9300-5699d3928106", null, "Admin", "ADMIN" }
                });
        }
    }
}

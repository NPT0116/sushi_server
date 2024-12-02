using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class orderByCanBeNull : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "638d8ee6-0c71-4d44-b6cc-07a3fa735dd2");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "8c7e7a81-600e-48b0-9e66-f953110d9867");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b01534ef-e16f-46ee-8a85-c945155a688e");

            migrationBuilder.AlterColumn<Guid>(
                name: "OrderedBy",
                table: "Reservation",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "05aeb2de-0cbb-4a6e-973c-d192ed960c1b", null, "Admin", "ADMIN" },
                    { "15c44789-6442-4f51-b0e1-67cf29e0edd5", null, "User", "USER" },
                    { "af75ec2a-78e5-4b67-98ff-392ae541008f", null, "Emp", "EMP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "05aeb2de-0cbb-4a6e-973c-d192ed960c1b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "15c44789-6442-4f51-b0e1-67cf29e0edd5");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "af75ec2a-78e5-4b67-98ff-392ae541008f");

            migrationBuilder.AlterColumn<Guid>(
                name: "OrderedBy",
                table: "Reservation",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "638d8ee6-0c71-4d44-b6cc-07a3fa735dd2", null, "User", "USER" },
                    { "8c7e7a81-600e-48b0-9e66-f953110d9867", null, "Emp", "EMP" },
                    { "b01534ef-e16f-46ee-8a85-c945155a688e", null, "Admin", "ADMIN" }
                });
        }
    }
}

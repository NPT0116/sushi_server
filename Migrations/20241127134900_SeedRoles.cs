using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class SeedRoles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_TableDetail_BranchId_TableNumber",
                table: "TableDetail");

            migrationBuilder.DropIndex(
                name: "IX_Sections_SectionName",
                table: "Sections");

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

            migrationBuilder.AlterColumn<string>(
                name: "SectionName",
                table: "Sections",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.AlterColumn<string>(
                name: "SectionName",
                table: "Sections",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5696c690-61c2-4ce7-83e2-da2e03cc49ff", null, "User", "USER" },
                    { "6eaddb63-1825-45cc-aed4-c7af1057c70d", null, "Emp", "EMP" },
                    { "9f7594c4-6315-4277-a07e-2b2a7a60f9f9", null, "Admin", "ADMIN" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_TableDetail_BranchId_TableNumber",
                table: "TableDetail",
                columns: new[] { "BranchId", "TableNumber" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Sections_SectionName",
                table: "Sections",
                column: "SectionName",
                unique: true);
        }
    }
}

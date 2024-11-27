using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class seed_role : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                    { "55b6fb40-8723-4e68-b26a-db64593bf9e1", null, "Emp", "EMP" },
                    { "b56c0bd5-777e-40f2-a50b-01dd84ba208c", null, "User", "USER" },
                    { "e5c60ce4-77a8-4e86-8f04-91fc0d7dd143", null, "Admin", "ADMIN" }
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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
                keyValue: "55b6fb40-8723-4e68-b26a-db64593bf9e1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b56c0bd5-777e-40f2-a50b-01dd84ba208c");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e5c60ce4-77a8-4e86-8f04-91fc0d7dd143");

            migrationBuilder.AlterColumn<string>(
                name: "SectionName",
                table: "Sections",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");
        }
    }
}

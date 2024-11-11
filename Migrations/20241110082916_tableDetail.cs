using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class tableDetail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9e9938d1-c78f-42fe-b6ea-f71ab813f728");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "a496f010-5123-422f-be16-93d54b142407");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b0ee1b20-509a-4661-baa2-df421a596f87");

            migrationBuilder.CreateTable(
                name: "TableDetail",
                columns: table => new
                {
                    TableId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    BranchId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TableNumber = table.Column<int>(type: "int", nullable: false),
                    MaxPeople = table.Column<int>(type: "int", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TableDetail", x => x.TableId);
                    table.ForeignKey(
                        name: "FK_TableDetail_Branches_BranchId",
                        column: x => x.BranchId,
                        principalTable: "Branches",
                        principalColumn: "BranchId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5133e80b-fde6-4dcd-bcaf-d22600b825c9", null, "Admin", "ADMIN" },
                    { "702d2f8a-a71f-4677-88af-23bd5a9edcb9", null, "Emp", "EMP" },
                    { "fd0448de-ac4c-4ac2-ac24-508fb30736b0", null, "User", "USER" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_TableDetail_BranchId_TableNumber",
                table: "TableDetail",
                columns: new[] { "BranchId", "TableNumber" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TableDetail");

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
                    { "9e9938d1-c78f-42fe-b6ea-f71ab813f728", null, "User", "USER" },
                    { "a496f010-5123-422f-be16-93d54b142407", null, "Emp", "EMP" },
                    { "b0ee1b20-509a-4661-baa2-df421a596f87", null, "Admin", "ADMIN" }
                });
        }
    }
}

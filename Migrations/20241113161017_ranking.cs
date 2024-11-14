using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class ranking : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "13585a1a-ed81-404c-9943-4e1caaf679e7");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9f20e900-fd9c-4f81-b94f-32c5f1f8502b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "d8acd0e8-c3aa-4429-ae28-64d7d87a6dc1");

            migrationBuilder.CreateTable(
                name: "Rankings",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RequirePoint = table.Column<int>(type: "int", nullable: false),
                    Discount = table.Column<int>(type: "int", nullable: false),
                    UpgradePoint = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rankings", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "392fb7a8-a965-4233-b9d9-974d16d6ff6d", null, "Emp", "EMP" },
                    { "cfbcde85-9a95-4b27-b1d4-19c640d99852", null, "User", "USER" },
                    { "ea3c3bae-cd36-4694-886e-0a404a110518", null, "Admin", "ADMIN" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Rankings");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "392fb7a8-a965-4233-b9d9-974d16d6ff6d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "cfbcde85-9a95-4b27-b1d4-19c640d99852");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ea3c3bae-cd36-4694-886e-0a404a110518");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "13585a1a-ed81-404c-9943-4e1caaf679e7", null, "Admin", "ADMIN" },
                    { "9f20e900-fd9c-4f81-b94f-32c5f1f8502b", null, "User", "USER" },
                    { "d8acd0e8-c3aa-4429-ae28-64d7d87a6dc1", null, "Emp", "EMP" }
                });
        }
    }
}

using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TableDetail_Branches_BranchId",
                table: "TableDetail");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "40c61aee-8179-49b6-b207-599d465f292a");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "569f11a5-1136-4fea-b974-619d8aecf3af");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "fae804d7-3b4a-443e-826a-bbdc4f19d14a");

            migrationBuilder.DropColumn(
                name: "MaxPeople",
                table: "TableDetail");

            migrationBuilder.RenameColumn(
                name: "TableId",
                table: "TableDetail",
                newName: "Id");

            migrationBuilder.AlterColumn<int>(
                name: "Status",
                table: "TableDetail",
                type: "int",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit");

            migrationBuilder.AddColumn<long>(
                name: "MaxCapacity",
                table: "TableDetail",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.CreateTable(
                name: "Reservation",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Status = table.Column<int>(type: "int", nullable: false),
                    OrderedBy = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CustomerId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    BranchId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    OrderId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TableId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reservation", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reservation_TableDetail_TableId",
                        column: x => x.TableId,
                        principalTable: "TableDetail",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "0f8e6e15-3443-4649-a8be-7325cdaeabe1", null, "Admin", "ADMIN" },
                    { "1c91f521-4c03-4698-b210-268d9b4fffb1", null, "User", "USER" },
                    { "89f4b167-b4ee-4444-9e9a-51bc5d594d74", null, "Emp", "EMP" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_TableId",
                table: "Reservation",
                column: "TableId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Reservation");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "0f8e6e15-3443-4649-a8be-7325cdaeabe1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1c91f521-4c03-4698-b210-268d9b4fffb1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "89f4b167-b4ee-4444-9e9a-51bc5d594d74");

            migrationBuilder.DropColumn(
                name: "MaxCapacity",
                table: "TableDetail");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "TableDetail",
                newName: "TableId");

            migrationBuilder.AlterColumn<bool>(
                name: "Status",
                table: "TableDetail",
                type: "bit",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "MaxPeople",
                table: "TableDetail",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "40c61aee-8179-49b6-b207-599d465f292a", null, "User", "USER" },
                    { "569f11a5-1136-4fea-b974-619d8aecf3af", null, "Admin", "ADMIN" },
                    { "fae804d7-3b4a-443e-826a-bbdc4f19d14a", null, "Emp", "EMP" }
                });

            migrationBuilder.AddForeignKey(
                name: "FK_TableDetail_Branches_BranchId",
                table: "TableDetail",
                column: "BranchId",
                principalTable: "Branches",
                principalColumn: "BranchId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

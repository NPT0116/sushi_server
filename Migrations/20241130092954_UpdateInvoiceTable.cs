using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace sushi_server.Migrations
{
    /// <inheritdoc />
    public partial class UpdateInvoiceTable : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        // Xóa bảng Invoices cũ
        migrationBuilder.DropTable(
            name: "Invoices");

        // Tạo lại bảng Invoices với cột Id là Guid
        migrationBuilder.CreateTable(
            name: "Invoices",
            columns: table => new
            {
                Id = table.Column<Guid>(nullable: false, defaultValueSql: "NEWID()"), // Cột Id là Guid
                Total = table.Column<long>(nullable: false),
                PaymentMethod = table.Column<string>(nullable: false),
                AfterDiscount = table.Column<int>(nullable: false),
                BonusPoint = table.Column<int>(nullable: false),
                Paid = table.Column<bool>(nullable: false),
                DatedOn = table.Column<DateTime>(nullable: false),
                OrderId = table.Column<Guid>(nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_Invoices", x => x.Id); // Cột Id làm khóa chính
                table.ForeignKey(
                    name: "FK_Invoices_Orders_OrderId",
                    column: x => x.OrderId,
                    principalTable: "Orders",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        // Tạo index cho cột OrderId
        migrationBuilder.CreateIndex(
            name: "IX_Invoices_OrderId",
            table: "Invoices",
            column: "OrderId");
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        // Xóa bảng Invoices đã tạo lại trong bước Up
        migrationBuilder.DropTable(
            name: "Invoices");

        // Tạo lại bảng Invoices với cột Id là int và có Identity (nếu cần thiết)
        migrationBuilder.CreateTable(
            name: "Invoices",
            columns: table => new
            {
                Id = table.Column<int>(nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"), // Cột Id là int với Identity
                Total = table.Column<long>(nullable: false),
                PaymentMethod = table.Column<string>(nullable: false),
                AfterDiscount = table.Column<int>(nullable: false),
                BonusPoint = table.Column<int>(nullable: false),
                Paid = table.Column<bool>(nullable: false),
                DatedOn = table.Column<DateTime>(nullable: false),
                OrderId = table.Column<Guid>(nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_Invoices", x => x.Id);
                table.ForeignKey(
                    name: "FK_Invoices_Orders_OrderId",
                    column: x => x.OrderId,
                    principalTable: "Orders",
                    principalColumn: "Id",
                    onDelete: ReferentialAction.Cascade);
            });

        migrationBuilder.CreateIndex(
            name: "IX_Invoices_OrderId",
            table: "Invoices",
            column: "OrderId");
    }
}

}

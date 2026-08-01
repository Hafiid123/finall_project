using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace online_mr_certi.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddCertificateFeePaymentMethod : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CertificateFeePaymentMethod",
                table: "marriage_applications",
                type: "varchar(30)",
                maxLength: 30,
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CertificateFeePaymentMethod",
                table: "marriage_applications");
        }
    }
}

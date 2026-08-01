using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20260720110000_AddCertificateFeeTracking")]
    public partial class AddCertificateFeeTracking : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeStatus",
                table: "marriage_applications",
                type: "varchar(30)",
                maxLength: 30,
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "CertificateFeeAmount",
                table: "marriage_applications",
                type: "decimal(18,2)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "CertificateFeePaidAt",
                table: "marriage_applications",
                type: "datetime(6)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeVerifiedBy",
                table: "marriage_applications",
                type: "varchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "CertificateFeeVerifiedAt",
                table: "marriage_applications",
                type: "datetime(6)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeReceiptImage",
                table: "marriage_applications",
                type: "varchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeSenderPhone",
                table: "marriage_applications",
                type: "varchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeTransactionNumber",
                table: "marriage_applications",
                type: "varchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificateFeeRejectionReason",
                table: "marriage_applications",
                type: "varchar(500)",
                maxLength: 500,
                nullable: true);

            // Seed default fees
            migrationBuilder.Sql(@"
                INSERT INTO `fees` (`ServiceName`, `Amount`, `Currency`, `IsActive`, `CreatedAt`)
                SELECT 'Appointment Fee', 15.00, 'USD', 1, UTC_TIMESTAMP()
                WHERE NOT EXISTS (SELECT 1 FROM `fees` WHERE `ServiceName` = 'Appointment Fee');
            ");
            migrationBuilder.Sql(@"
                INSERT INTO `fees` (`ServiceName`, `Amount`, `Currency`, `IsActive`, `CreatedAt`)
                SELECT 'Certificate Fee', 10.00, 'USD', 1, UTC_TIMESTAMP()
                WHERE NOT EXISTS (SELECT 1 FROM `fees` WHERE `ServiceName` = 'Certificate Fee');
            ");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(name: "CertificateFeeStatus", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeAmount", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeePaidAt", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeVerifiedBy", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeVerifiedAt", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeReceiptImage", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeSenderPhone", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeTransactionNumber", table: "marriage_applications");
            migrationBuilder.DropColumn(name: "CertificateFeeRejectionReason", table: "marriage_applications");
        }
    }
}

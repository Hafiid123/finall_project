using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

[DbContext(typeof(AppDbContext))]
[Migration("20260720100000_AddPaymentAndAppointmentFields")]
public partial class AddPaymentAndAppointmentFields : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `payments`
            MODIFY COLUMN `UserId` int NULL;
            """);

        migrationBuilder.Sql(
            """
            ALTER TABLE `payments`
            ADD COLUMN `ApplicationFee` decimal(18,2) NOT NULL DEFAULT 0,
            ADD COLUMN `PaymentMethod` varchar(20) NULL,
            ADD COLUMN `PaymentProofPath` varchar(500) NULL,
            ADD COLUMN `TransactionReference` varchar(100) NULL,
            ADD COLUMN `RejectionReason` varchar(500) NULL,
            ADD COLUMN `VerifiedBy` varchar(200) NULL,
            ADD COLUMN `VerifiedAt` datetime(6) NULL;
            """);

        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_applications`
            ADD COLUMN `AppointmentDate` datetime(6) NULL,
            ADD COLUMN `AppointmentTime` varchar(50) NULL,
            ADD COLUMN `AppointmentStatus` varchar(30) NOT NULL DEFAULT 'Pending';
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_applications`
            DROP COLUMN `AppointmentDate`,
            DROP COLUMN `AppointmentTime`,
            DROP COLUMN `AppointmentStatus`;
            """);

        migrationBuilder.Sql(
            """
            ALTER TABLE `payments`
            DROP COLUMN `ApplicationFee`,
            DROP COLUMN `PaymentMethod`,
            DROP COLUMN `PaymentProofPath`,
            DROP COLUMN `TransactionReference`,
            DROP COLUMN `RejectionReason`,
            DROP COLUMN `VerifiedBy`,
            DROP COLUMN `VerifiedAt`;
            """);

        migrationBuilder.Sql(
            """
            ALTER TABLE `payments`
            MODIFY COLUMN `UserId` int NOT NULL;
            """);
    }
}

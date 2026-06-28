using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

[DbContext(typeof(AppDbContext))]
[Migration("20260526120000_AddMarriageApplicationExtendedDetails")]
public partial class AddMarriageApplicationExtendedDetails : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_applications`
            ADD COLUMN `HusbandFatherName` varchar(200) NULL,
            ADD COLUMN `HusbandMotherName` varchar(200) NULL,
            ADD COLUMN `HusbandNationality` varchar(100) NULL,
            ADD COLUMN `HusbandOccupation` varchar(150) NULL,
            ADD COLUMN `HusbandResidenceStatus` varchar(30) NULL,
            ADD COLUMN `HusbandMaritalStatus` varchar(30) NULL,
            ADD COLUMN `WifeFatherName` varchar(200) NULL,
            ADD COLUMN `WifeMotherName` varchar(200) NULL,
            ADD COLUMN `WifeNationality` varchar(100) NULL,
            ADD COLUMN `WifeOccupation` varchar(150) NULL,
            ADD COLUMN `WifeResidenceStatus` varchar(30) NULL,
            ADD COLUMN `WifeMaritalStatus` varchar(30) NULL,
            ADD COLUMN `MarriageType` varchar(30) NULL,
            ADD COLUMN `Meher` varchar(500) NULL;
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_applications`
            DROP COLUMN `HusbandFatherName`,
            DROP COLUMN `HusbandMotherName`,
            DROP COLUMN `HusbandNationality`,
            DROP COLUMN `HusbandOccupation`,
            DROP COLUMN `HusbandResidenceStatus`,
            DROP COLUMN `HusbandMaritalStatus`,
            DROP COLUMN `WifeFatherName`,
            DROP COLUMN `WifeMotherName`,
            DROP COLUMN `WifeNationality`,
            DROP COLUMN `WifeOccupation`,
            DROP COLUMN `WifeResidenceStatus`,
            DROP COLUMN `WifeMaritalStatus`,
            DROP COLUMN `MarriageType`,
            DROP COLUMN `Meher`;
            """);
    }
}

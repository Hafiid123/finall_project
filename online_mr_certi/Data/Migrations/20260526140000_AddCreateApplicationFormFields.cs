using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

[DbContext(typeof(AppDbContext))]
[Migration("20260526140000_AddCreateApplicationFormFields")]
public partial class AddCreateApplicationFormFields : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_applications`
            ADD COLUMN `HusbandReligion` varchar(100) NULL,
            ADD COLUMN `WifeReligion` varchar(100) NULL,
            ADD COLUMN `SheikhName` varchar(200) NULL;

            ALTER TABLE `marriage_applications`
            MODIFY COLUMN `HusbandMaritalStatus` varchar(100) NULL,
            MODIFY COLUMN `WifeMaritalStatus` varchar(100) NULL;

            ALTER TABLE `marriage_witnesses`
            ADD COLUMN `FatherName` varchar(200) NULL;
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_witnesses`
            DROP COLUMN `FatherName`;

            ALTER TABLE `marriage_applications`
            MODIFY COLUMN `HusbandMaritalStatus` varchar(30) NULL,
            MODIFY COLUMN `WifeMaritalStatus` varchar(30) NULL,
            DROP COLUMN `SheikhName`,
            DROP COLUMN `WifeReligion`,
            DROP COLUMN `HusbandReligion`;
            """);
    }
}

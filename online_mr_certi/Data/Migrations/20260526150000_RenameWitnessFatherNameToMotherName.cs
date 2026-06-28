using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

[DbContext(typeof(AppDbContext))]
[Migration("20260526150000_RenameWitnessFatherNameToMotherName")]
public partial class RenameWitnessFatherNameToMotherName : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_witnesses`
            CHANGE COLUMN `FatherName` `MotherName` varchar(200) NULL;
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            ALTER TABLE `marriage_witnesses`
            CHANGE COLUMN `MotherName` `FatherName` varchar(200) NULL;
            """);
    }
}
